#!/bin/bash

git submodule update --init --recursive

export HUGO="hugo"

if ((${#REPOSITORY_URL[@]})); then
	# Netlify
	export HUGO="hugo_0.19"
fi

echo "Using ${HUGO} ..."

cd _script

./generateThemeSite.sh

echo "Building site to public ..."

${HUGO} --quiet -s hugoThemeSite/themeSite

cd ..

echo "Done!"