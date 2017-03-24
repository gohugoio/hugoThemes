#!/bin/bash

git submodule update --init --recursive

# TODO(bep) Get rid of the hacky themes symbolic link an move all themes submodules below /themes.
cd _script

./generateThemeSite.sh

echo "Building site to public ..."

hugo --quiet -s hugoThemeSite/themeSite

cd ..

echo "Done!"