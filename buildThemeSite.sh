#!/bin/bash

git submodule update --init --recursive

echo "Hugo env:"

hugo env

cd _script

BASEURL=${BASEURL:-http://localhost:1313}

./generateThemeSite.sh ${BASEURL}

echo "Building site to public with baseURL ${BASEURL}..."

hugo --quiet -s hugoThemeSite/themeSite -b ${BASEURL}

cd ..

echo "Done!"