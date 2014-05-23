#!/bin/sh
`adt -package -target ane growthpush.ane extension.xml -swc bin/GrowthPush-ANE.swc -platform Android-ARM -platformoptions android-options.xml -C platform/android . -platform iPhone-ARM -C platform/iphone . -platform default -C platform/default .`
