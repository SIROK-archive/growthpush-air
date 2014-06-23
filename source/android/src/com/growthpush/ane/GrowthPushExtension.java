package com.growthpush.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class GrowthPushExtension implements FREExtension {

	public FREContext createContext(String arg0) {
		return new GrowthPushContext();
	}

	public void dispose() {

	}

	public void initialize() {

	}

}
