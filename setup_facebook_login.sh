#!/bin/bash
# Ask the user for their name
echo "Setup facebook login"

echo "For which environment is this setup (dev/prod)"
read setupEnv

echo "Facebook APP ID"
read fbAppId

echo "Facebook APP CLIENT TOKEN"
read fbAppToken

echo "Facebook APP Name"
read fbAppName

echo ====================================
echo ==========    UPDATING    ==========
echo ====================================

if [ "$setupEnv" == "dev" ]
then
    grep --exclude=./setup_facebook_login.sh -r -l "facebook-app-name-dev" . | sort | uniq | xargs perl -e "s/facebook-app-name-dev/$fbAppName/" -pi
    grep --exclude=./setup_facebook_login.sh -r -l "facebook-app-id-dev" . | sort | uniq | xargs perl -e "s/facebook-app-id-dev/$fbAppId/" -pi
    grep --exclude=./setup_facebook_login.sh -r -l "facebook-app-token-dev" . | sort | uniq | xargs perl -e "s/facebook-app-token-dev/$fbAppToken/" -pi
fi

if [ "$setupEnv" == "prod" ]
then
    grep --exclude=./setup_facebook_login.sh -r -l "facebook-app-name-prod" . | sort | uniq | xargs perl -e "s/facebook-app-name-prod/$fbAppName/" -pi
    grep --exclude=./setup_facebook_login.sh -r -l "facebook-app-id-prod" . | sort | uniq | xargs perl -e "s/facebook-app-id-prod/$fbAppId/" -pi
    grep --exclude=./setup_facebook_login.sh -r -l "facebook-app-token-prod" . | sort | uniq | xargs perl -e "s/facebook-app-token-prod/$fbAppToken/" -pi
fi

echo "All done!"