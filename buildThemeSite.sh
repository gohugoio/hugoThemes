#!/bin/bash

# We may move this update bit to CircleCI or Travis with Cron later, but for now we just trigger updates on every build.
git submodule update --remote --merge
if ! git diff-index --quiet HEAD --; then
   git commit -am "Update themes"
	git push
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