package com.growthpush.ane.function;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.growthpush.GrowthPush;

public class SetTagFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] args) {

		if (args.length < 1)
			return null;

		String name = null;
		String value = null;

		try {

			if (args[0] != null)
				name = args[0].getAsString();
			if (args[1] != null)
				value = args[1].getAsString();

		} catch (IllegalStateException e) {
		} catch (FRETypeMismatchException e) {
		} catch (FREInvalidObjectException e) {
		} catch (FREWrongThreadException e) {
		}

		if (name != null)
			GrowthPush.getInstance().setTag(name, value);

		return null;
	}

}
