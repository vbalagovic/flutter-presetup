# Setup

#### Step 1) Update the project name

I made a little script that will update everything accordingly so run:

```
sh rename.sh
```

NOTE if the script does not execute till the end: If the last command grep and replace is not working on your OS just search and replace inside your text editor for "presetup" which is the current package name and replace every occurrence with something you want.

#### Step 2) Create a Signature key for the Android

I made a little script that should run everything accordingly so run (use the code from the script manually if something is not working). key.properties file will be updated or created:

```
sh create_signature.sh
```

#### Step 3) Update icons

Update the icons in assets/launcher icons folder and use the same naming. Run the following command since the project uses flutter launcher icons.

```
fvm flutter pub get && fvm flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*
```

#### Step 4) Generate freezed files

```
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

#### Step 5) Adding Firebase

You can use an approach where you create a firebase project for ios and android, and just update google services dev/prod and GoogleInfo.plist accordingly. I'll try to fasten things up with the new firebase flutter option, using FlutterFire CLI. (Scroll to First use for the first time setup)

Run the following command that will trigger flutterfire configure, check ios and android let te script update build gradle and then it will move files where needed.

```
sh setup_firebase.sh
```

**The first use of firebase CLI setup**

Before you continue, make sure to:

* Install the Firebase CLI and log in (run firebase login)
* From any directory, run this command:

```
dart pub global activate flutterfire_cli
```

Then, at the root of your Flutter project directory, run this command:

```
sh setup_firebase.sh
```

that will trigger the command below and put the files where they are needed for this setup

This automatically registers your per-platform apps with Firebase and adds a lib/firebase\_options.dart configuration file to your Flutter project.
