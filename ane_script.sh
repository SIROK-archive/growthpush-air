#!/bin/sh
ANE_BASE='source/ane'
ARCHIVE='growthpush.ane'
`adt -package -target ane ${ARCHIVE} ${ANE_BASE}/extension.xml -swc ${ANE_BASE}/bin/GrowthPush-ANE.swc -platform Android-ARM -platformoptions ${ANE_BASE}/android-options.xml -C ${ANE_BASE}/platform/android . -platform iPhone-ARM -C ${ANE_BASE}/platform/iphone . -platform default -C ${ANE_BASE}/platform/default .`
