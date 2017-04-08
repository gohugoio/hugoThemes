#!/bin/bash

git submodule update --init --recursive

export HUGO="hugo"

if ((${#REPOSITORY_URL[@]})); then
	# Netlify
	export HUGO="hugo_0.19"
fi

echo "Using ${HUGO} ..."

cd _script

BASEURL=${BASEURL:-http://localhost:1313}

./generateThemeSite.sh ${BASEURL}

echo "Building site to public with baseURL ${BASEURL}..."

${HUGO} --quiet -s hugoThemeSite/themeSite -b ${BASEURL}

cd ..

echo "Done!"