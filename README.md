# Flutter Presetup project

This is a small project that saves me time when I need to start new project from scratch including flavors and firebase. It's kinda suited to my needs but it may help someone. Currently it's focused on iOS and Android.

Related article: https://medium.com/itnext/flutter-new-app-setup-with-flavors-in-one-go-331471b127e3

## Screenshots

<p float="left">
  <img src="https://user-images.githubusercontent.com/30495155/212721492-ef0bf13f-f497-4ac1-9f68-7fff40a87932.png" width="250" />
  <img src="https://user-images.githubusercontent.com/30495155/212721593-34602878-e152-4eea-b7ef-1484fe328dca.png" width="250" />
  <img src="https://user-images.githubusercontent.com/30495155/212721626-b327b8c4-c0e6-4913-a6c7-a4020d054261.png" width="250" />
</p>

## Dependencies & versions

Current Flutter version 3.3.10

Install all dependecies:

```bash
fvm flutter pub get
```

Dependencies used:

- Easy localization
- Go router
- Riverpod
- Flutter launcher icons
- flavors

### Step 1) Update project name

I made a little script that will update everything accordingly so run:

```bash
sh rename.sh
```

NOTE if script does not execute till the end:
If the last command grep and replace is not working on your OS just search and replace inside your text editor for "presetup" which is current package name and replace every occurance with something you want.

### Step 2) Create Signature key for Android

I made a little script that should run everything accordingly so run (use the code from the script manually if something is not working). key.properties file will be updated or created:

```bash
sh create_signature.sh
```

### Step 3) Update icons

Update the icons in assets/launcher icons folder and use same naming. Run following command since project uses flutter launcher icons.

```bash
fvm flutter pub get && fvm flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*
```

### Step 4) Generate freezed files

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 5) Adding firebase

You can use approach where you create firebase project for ios and android, and just update google services dev/prod and GoogleInfo.plist accordingly. I'll try to fasten things up with new firebase flutter option, using FlutterFire CLI. (Scroll to First use for the first time setup)

Run the following command that will trigger flutterfire configure, check ios and android let te script update build gradle and then it will move files where needed.

```bash
sh setup_firebase.sh
```

#### First use of firebase CLI setup

Before you continue, make sure to:

- Install the Firebase CLI and log in (run firebase login)
- From any directory, run this command:

```bash
dart pub global activate flutterfire_cli
```

Then, at the root of your Flutter project directory, run this command:

```bash
sh setup_firebase.sh
```

that will trigger command below and put the files where they are needed for this setup

This automatically registers your per-platform apps with Firebase and adds a lib/firebase_options.dart configuration file to your Flutter project.

___________

## Authentication

### Firebase login

- Riverpod with go router is added to listen for changes in auth state
- Anonymus login works by default when you enable it on firebase with this code
- Social Login updates are coming

#### Google social login

Social login with google has been implemented as example. You need to add google login to your firebase auth and then run this script. It'll ask for a Google Reversed Id to update ios data per environment.

```bash
sh setup_google_login.sh
```

#### Facebook social login

Social login with facebook has been implemented as example. You need to add facebook login to your firebase auth and then run this script. It'll ask for a app id, token(secret) and app name. Package that was used is https://facebook.meedu.app/docs/5.x.x/intro but no implementation to code should be done. Just create facebook app for credentials.

```bash
sh setup_facebook_login.sh
```

#### Apple social login

Apple social login for iOS should work when you setup your Firebase (enable apple signup) and add "Sign in with apple capabilities" on your apple developer account to this identifier. Update provision file or just open xcode and recheck automatic provisioning if it's not working.

___________

## Google Ads

### Setup admob

- First you need to create admob account
- Create iOS and android application and get ad mob id in admob app settings
- Run script to add this ad mob id-s everywhere where needed

```bash
sh setup_admob_credentials.sh
```

After running this script all 3 types of ads should be working.

There are three examples of apps so you can create them and update `ad_helper.dart`with correct id per type of app. Current values are test ids so you can use them for test purposes.

#### Banner Ads

Create banner add and update `ad_helper.dart` file `bannerAdUnitId` variable, link to banner ad if you have some issues [Banner ad](https://developers.google.com/admob/flutter/banner/get-started)

#### Rewarded Interstitial As

Create banner add and update `ad_helper.dart` file `rewardedInterstitialAdUnitId` variable, link to reward int. ad if you have some issues [Rewarded Interstitial ad](https://developers.google.com/admob/flutter/rewarded-interstitial)

#### Native Ads

There is a example of native list ad. Design can be changed in `list_tile_native_ad.xml` file for android & `ListTileNativeAdView.xib` for iOS. For any updates check the article about native ads in flutter. [Native Ads](https://medium.com/itnext/flutter-native-ads-92d802fbd927)

___________

## Extracted widgets

### Theme

- theme is extracted to FPTheme class and can be used and updated also the dark version data is there
- FPButton is extracted component with integrated loader

___________

## Cleaner

You can clean project build with this script

```bash
sh flutter_cleaner.sh
```
