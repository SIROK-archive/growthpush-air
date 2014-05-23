package com.growthpush.ane.function;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.growthpush.GrowthPush;

public class RegisterFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] args) {

		String senderId = null;
		try {

			if (args[0] != null)
				senderId = args[0].getAsString();

		} catch (IllegalStateException e) {
		} catch (FRETypeMismatchException e) {
		} catch (FREInvalidObjectException e) {
		} catch (FREWrongThreadException e) {
		}

		if (senderId != null)
			GrowthPush.getInstance().register(senderId);

		return null;
	}

}
