#!/bin/bash
# Ask the user for their name
echo "Setup dynamic links"

echo "For which environment is this setup (dev/prod)"
read setupEnv

echo "Dynamic link"
read dynamicLink

echo ====================================
echo ==========    UPDATING    ==========
echo ====================================

if [ "$setupEnv" == "dev" ]
then
    grep --exclude=./setup_dynamic_links.sh -r -l "flutter-prestup.page.link" . | sort | uniq | xargs perl -e "s/flutter-prestup.page.link/$dynamicLink/" -pi
fi

if [ "$setupEnv" == "prod" ]
then
    grep --exclude=./setup_dynamic_links.sh -r -l "applinks:flutter-prestup-prod.page.link" . | sort | uniq | xargs perl -e "s/applinks:flutter-prestup-prod.page.link/$dynamicLink/" -pi
fi

echo "All done!"