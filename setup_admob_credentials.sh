#!/bin/bash
# Ask the user for their name
echo "Setup AddMobId"

echo "Dev [android] AddMobId (leave empty to skip the change) ca-app-pub...."
read devReversed

echo "Dev [iOS]  AddMobId (leave empty to skip the change) ca-app-pub...."
read devReversedIOS

echo "Production [android] AddMobId (leave empty to skip the change) ca-app-pub...."
read prodReversed

echo "Production [iOS] AddMobId (leave empty to skip the change) ca-app-pub...."
read prodReversedIOS

echo ====================================
echo ==========    UPDATING    ==========
echo ====================================


if [ -n "$devReversed" ]
then
    grep --exclude=./setup_admob_credentials.sh -r -l "admob-android-id-dev" . | sort | uniq | xargs perl -e "s/admob-android-id-dev/$devReversed/" -pi
fi

if [ -n "$devReversedIOS" ]
then
    grep --exclude=./setup_admob_credentials.sh -r -l "admob-ios-id-dev" . | sort | uniq | xargs perl -e "s/admob-ios-id-dev/$devReversedIOS/" -pi
fi

if [ -n "$prodReversed" ]
then
    grep --exclude=./setup_admob_credentials.sh -r -l "admob-android-id-prod" . | sort | uniq | xargs perl -e "s/admob-android-id-prod/$prodReversed/" -pi
fi

if [ -n "$prodReversedIOS" ]
then
    grep --exclude=./setup_admob_credentials.sh -r -l "admob-ios-id-prod" . | sort | uniq | xargs perl -e "s/admob-ios-id-prod/$prodReversedIOS/" -pi
fi

echo "All done!"