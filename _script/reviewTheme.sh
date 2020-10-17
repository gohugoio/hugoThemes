#!/bin/bash

# exit immediately if one the following commands throws an error
set -e

function help () {
    echo -ne  "This script is intended for quick theme reviews. The theme will be cloned into a dedicated directory if not already done. Themes already added to the theme site are ignored, thus total build time decreases. On success, the theme site will be served using the \"hugo server\" command.

Usage:

${BASH_SOURCE[0]} URL-TO-GIT-REPOSITORY [arguments]

Flags:

  -t    dedicated directory to clone theme to. Default is $scriptDir/review\n"
}

repoUrl=$1
# location of this script
scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# define location to clone theme to
themesDir="$scriptDir/review"

if [ $# -eq 0 ]; then
    echo -ne "Please provide a url to a Git repository containing the theme as the first argument, e.g. https://github.com/user/theme-name.git\n\n"
    help; exit 1
fi


# skip first argument (repoUrl)
OPTIND=2
while getopts ":t:" opt; do
    case $opt in
        t) themesDir=$OPTARG;;
        *) echo -ne "Unknown argument -$OPTARG provided.\n\n"; help; exit 1;;
    esac
done

themeName=$(basename $repoUrl .git)
cloneDest="$themesDir/$themeName"
if [ ! -d $cloneDest ]; then
    git clone --recursive $repoUrl $cloneDest
else
    echo " ==== Found theme \"$themeName\" already at $cloneDest. Skip cloning of theme ==== "
fi

# expose themesDir to generateThemeSite.sh
export HUGO_THEMES_REPO=$themesDir
# generate theme site and start hugo server.
"$scriptDir/generateThemeSite.sh" "http://localhost:1313" && hugo server -w=false -s hugoThemeSite/themeSite
