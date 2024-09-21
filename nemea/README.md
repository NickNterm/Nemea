# nemea

## Change Api Key and URLS

you

## Flavors

To user flavors you have to set up your ide to work with them.
set up only the ide from this link. See
vscode: https://felipeemidio.medium.com/flavors-with-flutter-1ddbaaf1146a

## Translations

If you don't see the translations and the app is weird run the generation of the translations

```
dart run easy_localization:generate -f keys -S ./assets/translations/ -o locale_keys.g.dart -O lib/utils -s el.json
```

## Build runner

You are going to get many *.g.dart missing files after installing the app. You have to run the build
runner go generate Hive, Chopper, BuildValue files.

```
dart run builder_runner build
```

## Change package name

https://pub.dev/packages/change_app_package_name
use this package. Go to pubspec.yaml and add the line of the
package: `change_app_package_name: ^1.4.0`. Then just run

```
flutter pub get
dart run change_app_package_name:main com.new.package.name
```
