//
//  GrowthPush_ANE_iOS.h
//  GrowthPush-ANE-iOS
//
//  Created by A13048 on 13/11/25.
//  Copyright (c) 2013年 Shigeru Ogawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import <GrowthPush/GrowthPush.h>

@interface GrowthPushANE : NSObject

+ (GrowthPushANE *) sharedInstance;

@end


FREObject EasyGrowthPushFunction(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);
FREObject InitializeFunction(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);
FREObject RegisterFunction(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);
FREObject SetDeviceTagsFunction(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);
FREObject SetTagFunction(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);
FREObject TrackEventFunction(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

void GPAneContextInitializer(void* extData,const uint8_t* ctxType,FREContext ctx,uint32_t* numFunctionsToTest,const FRENamedFunction** functionsToSet);
void GPAneContextFinalizer(FREContext ctx);

void GPAneExtInitializer(void** extDataToSet,FREContextInitializer* ctxInitializerToSet,FREContextFinalizer* ctxFinalizerToSet);
void GPAneExtFinalizer(void* extData);