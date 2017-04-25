#!/bin/bash

echo "Hugo env:"

hugo env

cd _script

BASEURL=${BASEURL:-http://localhost:1313}

./generateThemeSite.sh ${BASEURL}
if [ $code -ne 0 ]; then
	echo "generate theme site failed: exit status $code"
	exit 1
fi

echo "Building site to public with baseURL ${BASEURL}..."

hugo -s hugoThemeSite/themeSite -b ${BASEURL}
if [ $code -ne 0 ]; then
	echo "building theme site failed: exit status $code"
	exit 1
fi

cd ..

echo "Done!"