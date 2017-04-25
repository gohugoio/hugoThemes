#!/bin/bash

echo "Hugo env:"

hugo env

cd _script

BASEURL=${BASEURL:-http://localhost:1313}

if ! ./generateThemeSite.sh ${BASEURL}; then exit 1

echo "Building site to public with baseURL ${BASEURL}..."

if ! hugo --quiet -s hugoThemeSite/themeSite -b ${BASEURL}; then exit 1

cd ..

echo "Done!"