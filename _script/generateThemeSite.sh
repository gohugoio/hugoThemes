#!/bin/bash

function try() {
	"$@"
	code=$?
	if [ $code -ne 0 ]; then
		echo "$1 failed: exit status $code"
		exit 1
	fi
}

function fixReadme() {
	local content=$(cat $1)
	# Make images viewable outside GitHub
	content=$(echo "$content" | perl -p -e 's/github\.com\/(.*?)\/blob\/master\/images/raw\.githubusercontent\.com\/$1\/master\/images/g;')
	# Tell Hugo not to process shortcode samples
	content=$(echo "$content" | perl -0pe 's/\{\{%([^\/].*?)%\}\}/{{%\/*$1*\/%}}/sg;')
	content=$(echo "$content" | perl -0pe 's/\{\{<([^\/].*?)>\}\}/{{<\/*$1*\/>}}/sg;')

	echo "$content"
}

function fixThemeTOML() {
	local content=$(cat $1)

	# Make sure min_version is string, i.e min_version = 0.20.1 => min_version = "0.20.1"
	content=$(echo "$content" | perl -pe 's/min_version = (\d\S*)\n/min_version = "$1"\n/sg;')

	echo "$content"
}

# Silent pushd
pushd() {
	command pushd "$@" >/dev/null
}

# Silent popd
popd() {
	command popd "$@" >/dev/null
}

# Load the repositories from the provided environment variables or our defaults
HUGO_THEME_SITE_REPO=${HUGO_THEME_SITE_REPO:-https://github.com/gohugoio/hugoThemesSite.git}
HUGO_BASIC_EXAMPLE_REPO=${HUGO_BASIC_EXAMPLE_REPO:-https://github.com/gohugoio/hugoBasicExample.git}
#HUGO_THEMES_REPO=${HUGO_THEMES_REPO:-https://github.com/gohugoio/hugoThemes.git}

#echo "Using ${HUGO_THEMES_REPO} for themes"
echo "Using ${HUGO_THEME_SITE_REPO} for theme site"
echo "Using ${HUGO_BASIC_EXAMPLE_REPO} for example site"

GLOBIGNORE=.*
siteDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/hugoThemeSite"
themesDir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Using themes dir ${themesDir}"
echo "Using site dir ${siteDir}"

configTplPrefix="config-tpl"
configBase="${configTplPrefix}-base"
configBaseParams="${configTplPrefix}-params"

export HUGO_THEMESDIR=${themesDir}

# This is the hugo Theme Site Builder
mkdir -p hugoThemeSite

pushd hugoThemeSite

if [ -d themeSite ]; then
	pushd themeSite
	git pull --rebase --recurse-submodules origin master
	git submodule update --init --recursive
	popd
else
	git clone --recursive ${HUGO_THEME_SITE_REPO} themeSite
fi

if [ -d exampleSite ]; then
	pushd exampleSite
	git pull --rebase
	popd
else
	git clone ${HUGO_BASIC_EXAMPLE_REPO} exampleSite
fi


echo "BUILDING FROM" `pwd`

# Clean before new build
try rm -rf themeSite/public
try rm -rf themeSite/static/theme
try rm -rf themeSite/static/images
try rm -rf exampleSite2

mkdir -p themeSite/content
mkdir -p themeSite/static/images

if [ $# -eq 1 ]; then
	BASEURL="$1"
else
	BASEURL="http://themes.gohugo.io"
fi

# persona: https://github.com/pcdummy/hugo-theme-persona/issues/1
# html5: https://github.com/simonmika/hugo-theme-html5/issues/2
# journal discontinued
# aurora: https://github.com/coryshaw/hugo-aurora-theme/issues/1
# hugo-plus: https://github.com/H4tch/hugo-plus/issues/5
# yume: fails to render site for unknown reason, see https://github.com/gohugoio/hugoThemes/issues/190
blacklist=('persona', 'html5', 'journal', '.git', 'aurora', 'hugo-plus', 'yume', 'sofya', "hugo-theme-arch")

# hugo-incorporated: too complicated, needs its own
#   exampleSite: https://github.com/nilproductions/hugo-incorporated/issues/24
# hugo-theme-arch: themes generates blank homepage
# hugo-smpl-theme: Promotional non-Hugo links
# hugo-theme-learn: the theme owner requested the disable of the theme demo, see https://github.com/gohugoio/hugoThemes/issues/172
# hugo-finite: Too big
# lamp: Icon font does not work with baseURL with sub-folder.
noDemo=('hugo-incorporated', 'hugo-theme-arch', 'hugo-smpl-theme', 'hugo-finite', 'lamp')

errorCounter=0

for x in `find ${themesDir} -mindepth 1 -maxdepth 1 -type d -not -path "*.git" -not -path "*_script" | xargs -n1 basename`; do

	blacklisted=`echo ${blacklist[*]} | grep -w "$x"`
	if [ "${blacklisted}" != "" ]; then
		continue
	fi

	generateDemo=true
	inNoDemo=`echo ${noDemo[*]} | grep -w "$x"`
	if [ "${inNoDemo}" != "" ]; then
		generateDemo=false
	fi

	echo " ==== PROCESSING " $x " ====== "

	mkdir -p themeSite/content/$x

	cp ${themesDir}/$x/images/screenshot.png themeSite/content/$x/screenshot-$x.png
	# Use the thumbnail as featured image for the Twitter card etc.
	cp ${themesDir}/$x/images/tn.png themeSite/content/$x/tn-featured-$x.png


	title=$( echo "${x}" | tr "-" " " | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

	echo "+++" >themeSite/content/$x/index.md
	echo "title = \"$title\"" >>themeSite/content/$x/index.md
	repo=`git -C ${themesDir}/$x remote -v | head -n 1 | awk '{print$2}'`

	pushd ${themesDir}
	themeCreated=`git log --reverse --pretty=format:"%ai" $x | head -1`
	pushd $x
	themeUpdated=`git log --pretty=format:"%ai" -n1`
	popd
	popd

	if [ -z "$themeCreated" ]; then
		themeCreated=${themeUpdated}
	fi

	echo "date = \"$themeCreated\"" >>themeSite/content/$x/index.md
	echo "lastmod = \"$themeUpdated\"" >>themeSite/content/$x/index.md

	echo "source = \"$repo\"" >>themeSite/content/$x/index.md
	
	demoDestination="../themeSite/static/theme/$x/"

	export HUGO_CANONIFYURLS=true

    if $generateDemo; then
        if [ -d "${themesDir}/$x/exampleSite" ]; then
        	# Use content and config in exampleSite
            echo "Building site for theme ${x} using its own exampleSite to ${demoDestination}"

            # Hugo should exit with an error code on these ...
            if [ ! -d "${themesDir}/$x/exampleSite/content" ]; then
                echo "Example site for theme ${x} missing /content folder"
                generateDemo=false
            fi

            ln -s ${themesDir}/$x/exampleSite ${siteDir}/exampleSite2
            ln -s ${themesDir} ${siteDir}/exampleSite2/themes
            destionation="../themeSite/static/theme/$x/"
            hugo --quiet -s exampleSite2 -d ${demoDestination} -t $x -b $BASEURL/theme/$x/
            if [ $? -ne 0 ]; then
                echo "FAILED to create exampleSite for $x"
                errorCounter=$((errorCounter + 1))
                rm -rf ${demoDestination}
                generateDemo=false
            fi
            rm ${siteDir}/exampleSite2/themes
            rm ${siteDir}/exampleSite2

        else

            themeConfig="${TMPDIR}config-${x}.toml"
            baseConfig="${configBase}.toml"
            paramsConfig="${configBaseParams}.toml"

            if [ -f "themeSite/templates/${configBase}-${x}.toml" ]; then
                baseConfig="${configBase}-${x}.toml"
            fi

            if [ -f "themeSite/templates/${configBaseParams}-${x}.toml" ]; then
                paramsConfig="${configBaseParams}-${x}.toml"
            fi

            cat themeSite/templates/${baseConfig} >${themeConfig}
            cat themeSite/templates/${paramsConfig} >>${themeConfig}

            echo "Building site for theme ${x} using config \"${themeConfig}\" to ${demoDestination}"
            hugo --quiet -s exampleSite --config=${themeConfig} -d ${demoDestination} -t $x -b $BASEURL/theme/$x/
            if [ $? -ne 0 ]; then
                echo "FAILED to create demo site for $x"
                rm -rf ${demoDestination}
                errorCounter=$((errorCounter + 1))
                generateDemo=false
            fi
        fi
    fi

	if $generateDemo; then
		echo "demo = \"/theme/$x/\"" >> themeSite/content/$x/index.md
	fi

	fixThemeTOML ${themesDir}/$x/theme.toml >> themeSite/content/$x/index.md
	echo -en "\n+++\n\n" >>themeSite/content/$x/index.md

	if [ -f "${themesDir}/$x/README.md" ]; then
		fixReadme ${themesDir}/$x/README.md >> themeSite/content/$x/index.md
	else
		fixReadme ${themesDir}/$x/readme.md >> themeSite/content/$x/index.md
	fi
		
	if ((errorCounter > 50)); then
		echo "FAILED: Too many ($errorCounter) errors!"
		exit 1
	fi

done

unset GLOBIGNORE

echo -en "Finished with $errorCounter errors ...\n"

echo -en "**********************************************************************\n"
echo -en "\n"
echo -en "to view the site locally run 'hugo server -w=false -s _script/hugoThemeSite/themeSite\n"
echo -en "\n"
echo -en "**********************************************************************\n"
