package com.growthpush.ane.function;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.growthpush.GrowthPush;
import com.growthpush.model.Environment;

public class InitializeFunction implements FREFunction {

	public InitializeFunction() {
	}

	@Override
	public FREObject call(FREContext arg0, FREObject[] args) {

		if (args.length < 2) {
			return null;
		}

		int applicationId = 0;
		String secret = null;
		Environment environment = Environment.development;
		boolean debug = false;
		try {

			if (args[0] != null)
				applicationId = args[0].getAsInt();
			if (args[1] != null)
				secret = args[1].getAsString();
			if (args[2] != null)
				environment = Environment.valueOf(args[2].getAsString());
			if (args[3] != null)
				debug = args[3].getAsBool();

		} catch (IllegalStateException e) {
		} catch (FRETypeMismatchException e) {
		} catch (FREInvalidObjectException e) {
		} catch (FREWrongThreadException e) {
		}

		if (applicationId > 0 && secret != null)
			GrowthPush.getInstance().initialize(arg0.getActivity().getApplicationContext(), applicationId, secret, environment, debug);

		return null;

	}

}
