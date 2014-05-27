GrowthPush-AIR
==============

Growth Push SDK for Adobe AIR

Support SDK Version 13.0 more.

## Easy usage

```actionscript
GrowthPush.getInstance().initialize(YOUR_APPLICATION_ID, "YOUR_APPLICATION_SECRET", GrowthPush.PRODUCTION, true).register("YOUR_SENDER_ID");
GrowthPush.getInstance().setDeviceTags();
GrowthPush.getInstance().trackEvent("Launch");
```

That's all. GrowthPush instance will get APNS device token, send it to server, track launching event and tag the device information. You can get the app ID and secret on web site of GrowthPush.

You can get furthermore information on [GrowthPush documetations](https://growthpush.com/documents).
