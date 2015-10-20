GrowthPush-AIR
==============

:rotating_light: **This SDK is no longer maintained** :rotating_light:  

Growth Push SDK for Adobe AIR

Support SDK Version 13.0 more.

This SDK is not supported iOS 8.
Change Framework and re-build .ane file.

## Easy usage

```actionscript
GrowthPush.getInstance().initialize(YOUR_APPLICATION_ID, "YOUR_APPLICATION_SECRET", GrowthPush.PRODUCTION, true).register("YOUR_SENDER_ID");
GrowthPush.getInstance().setDeviceTags();
GrowthPush.getInstance().trackEvent("Launch");
```

That's all. GrowthPush instance will get APNS device token, send it to server, track launching event and tag the device information. You can get the app ID and secret on web site of GrowthPush.

You can get furthermore information on [GrowthPush documetations](https://growthpush.com/documents).

## How to build ANE

1. Build Static Library for iOS.

Open Xcode Project (souce/ios/GrowthPushANE.xcodeproj).

(If iOS 8 support, pull submodule latest commit .)

Archive static file.

Move archived file to source/ane/iphone/ .

1. Build Jar file for Android.

Open Android Project (source/android/).

Import > JAR File > growthpush.jar (for Eclipse).

Move archived file source/ane/andorid .

1. Build Ane file

Run ane_script.sh .

Archive growthpush.ane .

Import archived growthpush.ane to your project.
