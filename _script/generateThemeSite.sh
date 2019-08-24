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
blacklist=('persona', 'html5', 'journal', '.git', 'aurora', 'hugo-plus', 'yume', 'sofya', 'hugo-theme-arch', '.github')

# hugo-incorporated: too complicated, needs its own
#   exampleSite: https://github.com/nilproductions/hugo-incorporated/issues/24
# hugo-theme-arch: themes generates blank homepage
# hugo-smpl-theme: Promotional non-Hugo links
# hugo-theme-learn: the theme owner requested the disable of the theme demo, see https://github.com/gohugoio/hugoThemes/issues/172
# lamp: Icon font does not work with baseURL with sub-folder.
# hugo-theme-w3css-basic: the theme owner requested the disable of the theme demo, see https://github.com/gohugoio/hugoThemes/issues/555
# hugo-material-docs: theme is not compatible with more recent versions of Hugo
# devfest-theme-hugo: providing an exampleSite folders requires a lot of work, see https://github.com/gohugoio/hugoThemes/issues/584#issuecomment-467193735
noDemo=('hugo-incorporated', 'hugo-theme-arch', 'hugo-smpl-theme', 'lamp', 'hugo-theme-w3css-basic', 'hugo-material-docs', 'devfest-theme-hugo')

# A theme that uses other components needs to be added to this array
components=('hugo-bare-min-theme')

# academic: Popular theme aimed towards academia
# reveal-hugo: Presentation theme that depends on reveal.js
# hugo-terrassa-theme: business theme where hugoBasicExamples's content doesn't match the context
# hugo-theme-learn: documentation theme with custom shortcodes and own docs
# hugo-now-ui: Bootstrap-based material theme with custom docs and shortcodes for components
# dot-hugo-documentation-theme: business-focused knowledge base theme that require specific structure
# cupper-hugo-theme: Theme with accessibility features
# hugo-book: e-book theme needs its own content
# yourfolio: portfolio theme needs its own content
# hugo-resume: complicated resume theme needs its own content
# hugo-mdl: author parameter is an inline table
# hugo-dream-plus : author parameter is an inline table, also this theme needs its own content
# gohugo-theme-ananke: Quick start guide theme
# papercss-hugo-theme: provides custom short codes
# hugo-serif-theme: provides custom content for sub-pages
# hugo-theme-introduction: complicated theme with multilingual mode for several languages
# hugo-alabaster-theme: documentation theme needs its content
# docuapi: documentation theme needs its content
# hugo-theme-winning: single page resume theme draws its content from its own _index.md
# co-op: uses custom sections on the homepage that can be populated via content files
# hugo-piercer-theme: offers customizable sections on the homepage that require own content files
# minimo: is a very customizable theme that ships with widgets
# personal-web: uses custom content files for the portfolio section
# kitab: default content doesn't provide the structure to showcase books with chapters
# kross-hugo-portfolio-template: requires custom content for the portfolio section
# parsa-hugo-personal-blog-theme: is an image-heavy theme which heavily defines its appearance
# syna: the use of fragments requires custom content files
# crab: uses custom content to display features of the theme
# hugograyscale: a one-page theme whose homepage sections aren't covered by the default content
# hugo-creative-portfolio-theme: see https://github.com/gohugoio/hugoThemes/issues/649
# mero: uses custom pages archive and tags / categories. See https://github.com/gohugoio/hugoThemes/issues/593#issuecomment-505934333
# khata: uses custom pages archive and tags / categories
# OneDly-Theme: uses custom content to display subpages and sections on the homepage
# hugo-webslides: uses custom Markdown files for presentation slides
# ------------------------------------------------------------------------
# the following theme demos require their own content for various reasons:
# ------------------------------------------------------------------------
# hugo-minimalist-spa
# simplicity
# hugo-theme-den
# alpha-church
# castanet 
# hugo-apps-theme
# hugo-theme-techdoc
# hugo-theme-revealjs
# hugo-theme-robotico 
# hugo-travelify-theme
whiteList=('academic', 'reveal-hugo', 'hugo-terrassa-theme', 'hugo-theme-learn', 'hugo-now-ui', 'dot-hugo-documentation-theme', 'cupper-hugo-theme', 'hugo-book', 'yourfolio', 'hugo-resume', 'hugo-mdl', 'hugo-dream-plus', 'gohugo-theme-ananke', 'papercss-hugo-theme', 'hugo-serif-theme', 'hugo-theme-introduction', 'hugo-alabaster-theme', 'docuapi', 'hugo-theme-winning', 'co-op', 'hugo-piercer-theme', 'minimo', 'personal-web', 'kitab', 'kross-hugo-portfolio-template', 'parsa-hugo-personal-blog-theme', 'syna', 'crab', 'hugograyscale', 'hugo-creative-portfolio-theme', 'mero', 'khata', 'OneDly-Theme', 'hugo-webslides', 'hugo-minimalist-spa', 'hugo-theme-den', 'simplicity', 'alpha-church', 'castanet', 'hugo-apps-theme', 'hugo-theme-techdoc', 'hugo-theme-revealjs', 'hugo-theme-robotico', 'hugo-travelify-theme')

errorCounter=0

for x in `find ${themesDir} -mindepth 1 -maxdepth 1 -type d -not -path "*.git" -not -path "*_script" | xargs -n1 basename`; do

	blacklisted=`echo ${blacklist[*]} | grep -w "$x"`
	if [ "${blacklisted}" != "" ]; then
		echo " ==== SKIPPING " $x " is blacklisted ====== "
		continue
	fi

	generateDemo=true
	inNoDemo=`echo ${noDemo[*]} | grep -w "$x"`
	if [ "${inNoDemo}" != "" ]; then
		generateDemo=false
	fi

	skipEmptySubmodule=false
	if [ ! -f "${themesDir}/$x/theme.toml" ]; then
		echo " ==== SKIPPING " $x " (Submodule Empty) ====== "
		skipEmptySubmodule=true
	fi

	if ! $skipEmptySubmodule; then

	echo " ==== PROCESSING " $x " ====== "
	if [ "${inNoDemo}" != "" ]; then
                echo "${x} is in noDemo list"
	fi
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
	demoConfig="${themesDir}/$x/exampleSite/config"
        searchConfig="${themesDir}/$x/exampleSite/config.*"
	ignoreConfig="${siteDir}/exampleSite/confIgnore.toml"
	postsConfig="${siteDir}/exampleSite/configPosts.toml"
	taxoConfig="${siteDir}/exampleSite/configTaxo.toml"

	export HUGO_CANONIFYURLS=true

    if $generateDemo; then

        if [ -f "${themesDir}/$x/.gitmodules" ]; then
            pushd ${themesDir}/$x
            echo "Updating git submodules for theme $x"
            git submodule update --init --recursive
            popd
        fi

        if [ -d "${themesDir}/$x/exampleSite" ]; then
        	# Use content and config in exampleSite
            ln -s ${themesDir}/$x/exampleSite ${siteDir}/exampleSite2
            ln -s ${themesDir} ${siteDir}/exampleSite2/themes
            destination="../themeSite/static/theme/$x/"
            inWhiteList=`echo ${whiteList[*]} | grep -w "$x"`
            hasCompontents=`echo ${components[*]} | grep -w "$x"`
            if [ "${inWhiteList}" != "" ]; then
				echo "${x} is whitelisted"
				echo "Building site for theme ${x} using its own exampleSite to ${demoDestination}"
				# Hugo should exit with an error code on these ...
				if [ ! -d "${themesDir}/$x/exampleSite/content" ]; then
					echo "Example site for theme ${x} missing /content folder"
					generateDemo=false
				fi
            	HUGO_THEME=${x} hugo --quiet -s exampleSite2 -d ${demoDestination} -b $BASEURL/theme/$x/
            else
                                grep -v "enableEmoji" ${searchConfig} > temp && mv temp ${searchConfig}
				echo "Building site for theme ${x} using default content to ${demoDestination}"
				if grep -rFq '.Pages "Type" "posts"' ${themesDir}/$x/layouts/; then
				echo "Type posts found"
				HUGO_THEME=${x} hugo --quiet -s exampleSite2 -c ${siteDir}/exampleSite/content/ --config=${postsConfig},${demoConfig},${taxoConfig} -d ${demoDestination} -b $BASEURL/theme/$x/
                                elif [ "${hasCompontents}" != "" ]; then
				echo "Building site for theme ${x} with Theme Components"
                                perl -i -pe 's/kaushalmodi\/hugo-bare-min-theme/gohugoio\/hugoBasicExample/g | s/exampleSite\/content/content/g' ${searchConfig}
				hugo --quiet -s exampleSite2 -c ${siteDir}/exampleSite/content/ --themesDir ${themesDir}/$x/exampleSite/themes/ --config=${ignoreConfig},${demoConfig},${taxoConfig} -d ${demoDestination} -b $BASEURL/theme/$x/
rm -rf ${themesDir}/$x/exampleSite/themes/hugoThemes
				else
				HUGO_THEME=${x} hugo --quiet -s exampleSite2 -c ${siteDir}/exampleSite/content/ --config=${ignoreConfig},${demoConfig},${taxoConfig} -d ${demoDestination} -b $BASEURL/theme/$x/
				fi
            fi
            if [ $? -ne 0 ]; then
                echo "FAILED to create exampleSite for $x"
                errorCounter=$((errorCounter + 1))
                rm -rf ${demoDestination}
                generateDemo=false
            fi
            rm ${siteDir}/exampleSite2/themes
            rm ${siteDir}/exampleSite2

        else

            themeConfig="${siteDir}/config-${x}.toml"
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
            HUGO_THEME=${x} hugo --quiet -s exampleSite --config=${ignoreConfig},${themeConfig},${taxoConfig} -d ${demoDestination} -b $BASEURL/theme/$x/
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
