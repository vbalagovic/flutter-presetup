#!/bin/bash
# Ask the user for their name
echo "Install Bundler\\n"

gem install bundler

echo "\\nInstall Fastlane\\n"

cd $PWD/ios && bundle update && fastlane add_plugin firebase_app_distribution

cd ../android && bundle update && fastlane add_plugin firebase_app_distribution

cd ../ && cp .env.example .env.development && cp .env.example .env.production

echo "\\Done!\\n"
echo "\\nUpdate the .env.development & .env.productions files with your firebase credentials"