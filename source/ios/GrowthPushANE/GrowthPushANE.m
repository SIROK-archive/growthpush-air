//
//  GrowthPushANE.m
//  GrowthPushANE
//
//  Created by A13048 on 13/11/25.
//  Copyright (c) 2013年 Shigeru Ogawa. All rights reserved.
//

#import "GrowthPushANE.h"
#import "GPAppDelegateWrapper.h"

#define ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

static GrowthPushANE *_instance = nil;

@interface GPAneAppDelegateIntercepter : NSObject<GPAppDelegateWrapperDelegate>

@end

@interface GrowthPushANE () {
    
    GPAppDelegateWrapper *appDelegateWrapper;
    GPAneAppDelegateIntercepter *appDelegateIntercepter;
    EGPOption option;
    
}

@property (nonatomic, retain) GPAppDelegateWrapper *appDelegateWrapper;
@property (nonatomic, retain) GPAneAppDelegateIntercepter *appDelegateIntercepter;
@property (nonatomic, assign) EGPOption option;

@end

@implementation GPAneAppDelegateIntercepter

- (void) willPerformApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [GrowthPush setDeviceToken:deviceToken];
}

- (void) willPerformApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GrowthPush setDeviceToken:nil];
}

@end

@implementation GrowthPushANE

@synthesize appDelegateWrapper;
@synthesize appDelegateIntercepter;
@synthesize option;

+ (GrowthPushANE *) sharedInstance {
    @synchronized(self) {
        if(_instance == nil) {
            _instance = [[self alloc] init];
        }
        return _instance;
    }
}

+(GPAppDelegateWrapper *)appDelegateWrapper {
    return [self sharedInstance].appDelegateWrapper;
}

+(void) setAppDelegateWrapper:(GPAppDelegateWrapper *)_appDelegateWrapper{
    [self sharedInstance].appDelegateWrapper = _appDelegateWrapper;
}

+(GPAneAppDelegateIntercepter *)appDelegateInterceptor {
    return [self sharedInstance].appDelegateIntercepter;
}

+(void) setAppDelegateIntercepter:(GPAneAppDelegateIntercepter *)_appDelegateIntercepter {
    [self sharedInstance].appDelegateIntercepter = _appDelegateIntercepter;
}

+(void) setOption:(EGPOption)_option {
    [self sharedInstance].option = _option;
}

@end

GPEnvironment StringToEnvironment(FREObject arg){
    
    if (arg != NULL) {
        
        uint32_t environmentInt;
        const uint8_t *utf8_environment;
        FREGetObjectAsUTF8(arg, &environmentInt, &utf8_environment);
        NSString* environmentString = [NSString stringWithUTF8String:(char*)utf8_environment];
        
        if ([environmentString isEqualToString:@"development"])
            return GPEnvironmentDevelopment;
        if ([environmentString isEqualToString:@"production"])
            return GPEnvironmentProduction;
        
    }
    
    return GPEnvironmentUnknown;
    
}

ANE_FUNCTION(EasyGrowthPushFunction){
   
    if (argv[0] == NULL || argv[1] == NULL) {
        return nil;
    }
    
    uint32_t applicationId;
    FREGetObjectAsUint32(argv[0], &applicationId);
    
    uint32_t secretLength;
    const uint8_t *utf8_secret;
    FREGetObjectAsUTF8(argv[1], &secretLength, &utf8_secret);
    NSString* secret = [NSString stringWithUTF8String:(char*)utf8_secret];
    
    GPEnvironment environment = StringToEnvironment(argv[2]);
    
    uint32_t debug = 0;
    if (argv[3] != NULL) {
        FREGetObjectAsBool(argv[3], &debug);
    }
    
    [EasyGrowthPush setApplicationId:applicationId secret:secret environment:environment debug:debug option:EGPOptionAll];
    
    return nil;
}

ANE_FUNCTION(InitializeFunction){

    if (argv[0] == NULL || argv[1] == NULL) {
        return nil;
    }
    
    uint32_t applicationId;
    FREGetObjectAsUint32(argv[0], &applicationId);
    
    uint32_t secretLength;
    const uint8_t *utf8_secret;
    FREGetObjectAsUTF8(argv[1], &secretLength, &utf8_secret);
    NSString* secret = [NSString stringWithUTF8String:(char*)utf8_secret];
    
    GPEnvironment environment = StringToEnvironment(argv[2]);
    
    uint32_t debug = 0;
    if (argv[3] != NULL) {
        FREGetObjectAsBool(argv[3], &debug);
    }
    
    [GrowthPush setApplicationId:applicationId secret:secret environment:environment debug:(BOOL) debug];
    return nil;
}

ANE_FUNCTION(RegisterFunction){
    [GrowthPush requestDeviceToken];
    return nil;
}

ANE_FUNCTION(SetDeviceTagsFunction){
    [GrowthPush setDeviceTags];
    return nil;
}

ANE_FUNCTION(SetTagFunction){
    
    if (argv[0] == NULL) {
        return nil;
    }
    
    uint32_t nameInt;
    const uint8_t *utf8_name;
    FREGetObjectAsUTF8(argv[0], &nameInt, &utf8_name);
    NSString* name = [NSString stringWithUTF8String:(char*)utf8_name];
    
    NSString* value = NULL;
    if (argv[1] != NULL) {
        uint32_t valueInt;
        const uint8_t *utf8_value;
        FREGetObjectAsUTF8(argv[1], &valueInt, &utf8_value);
        value = [NSString stringWithUTF8String:(char*)utf8_value];
    }

    [GrowthPush setTag:name value:value];
    return nil;
}

ANE_FUNCTION(TrackEventFunction){

    if (argv[0] == NULL) {
        return nil;
    }
    
    uint32_t nameInt;
    const uint8_t *utf8_name;
    FREGetObjectAsUTF8(argv[0], &nameInt, &utf8_name);
    NSString* name = [NSString stringWithUTF8String:(char*)utf8_name];
    
    NSString* value = NULL;
    if (argv[1] != NULL) {
        uint32_t valueInt;
        const uint8_t *utf8_value;
        FREGetObjectAsUTF8(argv[1], &valueInt, &utf8_value);
        value = [NSString stringWithUTF8String:(char*)utf8_value];
    }
    
    [GrowthPush trackEvent:name value:value];
    return nil;

}

void GPAneContextInitializer(void* extData,const uint8_t* ctxType,FREContext ctx,uint32_t* numFunctionsToTest,const FRENamedFunction** functionsToSet){
    
    NSLog(@"context Initializer");
    
    [GrowthPushANE setAppDelegateWrapper:[[[GPAppDelegateWrapper alloc] init] autorelease]];
    [[GrowthPushANE appDelegateWrapper] setOriginalAppDelegate:[[UIApplication sharedApplication] delegate]];
    NSLog(@"delegateWrapper setOriginalDelegate");
    
    [GrowthPushANE setAppDelegateIntercepter:[[[GPAneAppDelegateIntercepter alloc] init] autorelease]];
    [[GrowthPushANE appDelegateWrapper] setDelegate:[GrowthPushANE appDelegateInterceptor]];
    NSLog(@"delegateWrapper setDelegateInterceptor");
    [[UIApplication sharedApplication] setDelegate:[GrowthPushANE appDelegateWrapper]];
    NSLog(@"UIApplication setDelegate");
    [GrowthPushANE setOption:EGPOptionAll];
    
    NSInteger functionSize = 6;
    *numFunctionsToTest = functionSize;
    FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction)* functionSize);
    func[0].name = (const uint8_t*) "EasyGrowthPush";
    func[0].functionData = NULL;
    func[0].function = &EasyGrowthPushFunction;
    
    func[1].name = (const uint8_t*) "initialize";
    func[1].functionData = NULL;
    func[1].function = &InitializeFunction;
    
    func[2].name = (const uint8_t*) "register";
    func[2].functionData = NULL;
    func[2].function = &RegisterFunction;
    
    func[3].name = (const uint8_t*) "setDeviceTags";
    func[3].functionData = NULL;
    func[3].function = &SetDeviceTagsFunction;
    
    func[4].name = (const uint8_t*) "setTag";
    func[4].functionData = NULL;
    func[4].function = &SetTagFunction;
    
    func[5].name = (const uint8_t*) "trackEvent";
    func[5].functionData = NULL;
    func[5].function = &TrackEventFunction;
    
    *functionsToSet = func;
    
}

void GPAneContextFinalizer(FREContext ctx){
    return;
}

void GPAneExtInitializer(void** extDataToSet,FREContextInitializer* ctxInitializerToSet,FREContextFinalizer* ctxFinalizerToSet){
    *extDataToSet = NULL;
    *ctxInitializerToSet = &GPAneContextInitializer;
    *ctxFinalizerToSet = &GPAneContextFinalizer;
}

void GPAneExtFinalizer(void* extData){
    return;
}
