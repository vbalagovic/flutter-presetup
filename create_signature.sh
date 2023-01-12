#!/bin/bash
# Ask the user for their name
echo "Create android key signature and update an key.properties! \n"

echo "What is your app desired key name?"
read keyName

echo "What is your app desired key alias?"
read keyAlias

echo "What is your desired password (you'll set this on key generation this is for key. properties file so let them be the same)"
read keyPassword

echo "What is your desired path? Default is current folder (eg. /User/john/documents/keystores)"
read keyPath

echo ====================================
echo =========   GENERATING    ==========
echo ====================================

if [ -z "$keyPath" ]
then
    keyPath=$(pwd)
fi

keytool -genkey -v -keystore "$keyPath/$keyName.jks" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias $keyAlias

echo "storePassword=$keyPassword
keyPassword=$keyPassword
keyAlias=$keyAlias
storeFile=$keyPath/$keyName.jks" > './android/key.properties'

echo -e "\n$keyName.jks" >> .gitignore

echo "Get your SHA1 and SHA256 from here"
keytool -list -v -keystore "$keyPath/$keyName.jks" -alias $keyAlias

echo "All done!"
