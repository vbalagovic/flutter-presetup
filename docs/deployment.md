# Deployment

### Deployment (via Fastlane)

For more detailed articles (slightly different .env organization of files only) you can check [App distribution Deploy](https://medium.com/itnext/flutter-fastlane-deployment-to-the-firebase-app-distribution-easy-way-d5ca2fbdcdf9) & [Store Deploy](https://medium.com/itnext/flutter-fastlane-deployment-to-the-google-play-app-store-easy-way-baa1f491cc51)

#### Firebase app distribution (example will be for dev environment)

Install fastlane:

```bash
sh setup_fastlane.sh
```

Populate `.env.development` in root folder with data and keys, for firebase you'll need to create new service account for selected app in [Google Cloud Console](https://console.cloud.google.com/projectselector2/iam-admin/serviceaccounts) follow the steps below:

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1\*jUjckYyRYStsFeSLFbEcPw.png) ![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1\*H8914HGCrmtUqS075yHeeA.png) ![](https://miro.medium.com/v2/resize:fit:1400/0\*eQvVMwj5BUbPtGgr)

Store the json file as `firebase-distribution-creds-dev.json` in root folder if you don't want to change the path in .env.development file

Update chengelog.txt file in root folder for release notes & deploy dev app to Firebase app distibution:

```bash
sh deploy_dev.sh
```

#### Google Play Store (example will be for prod environment)

Populate `.env.production` in root folder with data and keys, for that we need a JSON key file that will give us access to the play store which is explained [official docs](https://docs.fastlane.tools/actions/supply/#setup) I will add a screenshot for a sake of speed:

![](https://miro.medium.com/v2/resize:fit:1400/0\*HBIA0v\_QIk23UiHc)

Populate `ANDROID_FIREBASE_APP_DISTRIBUTION_CREDENTIALS_FILE_PATH` (or for the path store the file to root directory and name it `google-creds-prod.json`)

#### Apple Store Test Flight (example will be for prod environment)

Populate `.env.production` in root folder, As we did with google play here we’ll also create an API key to handle authentication from fastlane to the app store, copied from [testflight documentation](https://docs.fastlane.tools/app-store-connect-api/):

Creating an App Store Connect API Key:

* Create a new App Store Connect API Key in the [Users page](https://appstoreconnect.apple.com/access/api)
* For more info, go to the [App Store Connect API Docs](https://developer.apple.com/documentation/appstoreconnectapi/creating\_api\_keys\_for\_app\_store\_connect\_api)
* Select the “Keys” tab
* Give your API Key an appropriate role for the task at hand. You can read more about roles in [Permissions in App Store Connect](https://developer.apple.com/support/roles/)
* Note the Issuer ID as you will need it for the configuration steps below
* Download the newly created API Key file (.p8)
* This file cannot be downloaded again after the page has been refreshed Although the app manager or developer role should be enough, you can create a key with Admin permission if needed.

IMPORTANT: store the key somewhere safe!

Populate `KEY_ID`, `KEY_ISSUER_ID` & `PATH_TO_THE_P8_KEY` (or for the path store the file to root directory and name it `applestore_key.p8`)

### Deploy production to both stores

Update chengelog.txt file in root folder for release notes & deploy dev app to Firebase app distibution:

```bash
sh deploy_prod.sh
```
