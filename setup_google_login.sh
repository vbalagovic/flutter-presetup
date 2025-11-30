#!/bin/bash
# Ask the user for their name
echo "Setup google login key"

echo "Dev GOOGLE_REVERSED_CLIENT_ID (leave empty to skip the change)"
read devReversed

echo "Production GOOGLE_REVERSED_CLIENT_ID (leave empty to skip the change)"
read prodReversed

echo ====================================
echo ==========    UPDATING    ==========
echo ====================================


if [ -n "$devReversed" ]
then
    grep --exclude=./setup_google_login.sh -r -l "google-reversed-client-id-dev" . | sort | uniq | xargs perl -e "s/google-reversed-client-id-dev/$devReversed/" -pi
fi

if [ -n "$prodReversed" ]
then
    grep --exclude=./setup_google_login.sh -r -l "google-reversed-client-id-prod" . | sort | uniq | xargs perl -e "s/google-reversed-client-id-prod/$prodReversed/" -pi
fi

echo "All done!"