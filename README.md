# Flutter presetup

Install all dependecies:

```bash
fvm flutter pub get
```

## Step 1) Update project name

I made a little script that will update everything accordingly so run:

```bash
sh rename.sh
```

NOTE if script does not execute till the end:
If the last command grep and replace is not working on your OS just search and replace inside your text editor for "presetup" which is current package name and replace every occurance with something you want.

## Step 2) Create Signature key for Android

I made a little script that should run everything accordingly so run (use the code from the script manually if something is not working). key.properties file will be updated or created:

```bash
sh create_signature.sh
```

## Step 3) Update icons

Update the icons in assets/launcher icons folder and use same naming. Run following command since project uses flutter launcher icons.

```bash
fvm flutter pub get && fvm flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*
```
