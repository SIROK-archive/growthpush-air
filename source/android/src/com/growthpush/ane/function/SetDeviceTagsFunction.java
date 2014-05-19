package com.growthpush.ane.function;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.growthpush.GrowthPush;

public class SetDeviceTagsFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		GrowthPush.getInstance().setDeviceTags();
		return null;
	}

}
