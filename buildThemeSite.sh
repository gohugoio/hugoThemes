#!/bin/bash

# We may move this update bit to CircleCI or Travis with Cron later, but for now we just trigger updates on every build.
git config user.name "hugo-themebuilder"
git config user.email "hugo-themebuilder@gohugo.io"
git submodule update --remote --merge
if ! git diff-index --quiet HEAD --; then
   git commit -am "Update themes"
   git remote add origin git@github.com:spf13/hugoThemes.git
	git push origin master
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

echo "Hugo env:"

hugo env

cd _script

BASEURL=${BASEURL:-http://localhost:1313}

./generateThemeSite.sh ${BASEURL}
code=$?
if [ $code -ne 0 ]; then
	echo "generate theme site failed: Exit status $code"
	exit 1
fi

echo "Building site to public with baseURL ${BASEURL}..."

hugo --quiet -s hugoThemeSite/themeSite -b ${BASEURL}
code=$?
if [ $code -ne 0 ]; then
	echo "build theme site failed: Exit status $code"
	exit 1
fi

cd ..

echo "Done!"