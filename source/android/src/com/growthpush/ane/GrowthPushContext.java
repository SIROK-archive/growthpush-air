package com.growthpush.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.growthpush.ane.function.InitializeFunction;
import com.growthpush.ane.function.RegisterFunction;
import com.growthpush.ane.function.SetDeviceTagsFunction;
import com.growthpush.ane.function.SetTagFunction;
import com.growthpush.ane.function.TrackEventFunction;

public class GrowthPushContext extends FREContext {

	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {

		HashMap<String, FREFunction> result = new HashMap<String, FREFunction>();
		result.put("initialize", new InitializeFunction());
		result.put("register", new RegisterFunction());
		result.put("setDeviceTags", new SetDeviceTagsFunction());
		result.put("setTag", new SetTagFunction());
		result.put("trackEvent", new TrackEventFunction());

		return result;
	}

}
