package com.growthpush.ane
{
	import flash.external.ExtensionContext;

	/**
	 * @author Ogawa Shigeru
	 */
	public class GrowthPush
	{
		
		import flash.system.Capabilities;

		private static const instance:GrowthPush = new GrowthPush();
		private static const context:ExtensionContext = ExtensionContext.createExtensionContext("com.growthpush.ane", null);
		
		public static const PRODUCTION:String = "production";
		public static const DEVELOPMENT:String = "development";
		
		public static function getInstance():GrowthPush
		{
			return instance;
		}
		
		public function initialize(applicationId:int, secret:String, environment:String, debug:Boolean):GrowthPush
		{
			context.call("initialize", applicationId, secret, environment, debug);
			return instance;
		}
		
		public function register(senderId:String = null):void
		{
			if(senderId != null)
				context.call("register",senderId);
			else
				context.call("register");
		}
		
		public function setDeviceTags():void
		{
			context.call("setDeviceTags");
		}
		
		public function setTag(name:String, value:String = null):void
		{
			context.call("setTag",name,value);
		}
		
		public function trackEvent(name:String, value:String = null):void
		{
			context.call("trackEvent",name,value);
		}
		
		public function get isPushNotificationSupported():Boolean
		{
			var result:Boolean = (Capabilities.manufacturer.search('iOS') > -1 || Capabilities.manufacturer.search('Android') > -1);
			return result;
		}
		
		public function dispose():void
		{
			return context.dispose();
		}
	}	
}