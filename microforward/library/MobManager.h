//
//  MobManager.h
//  microforward
//
//  Created by 张小明 on 2017/8/3.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

//分享头文件
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <MOBFoundation/MOBFoundation.h>

//短信验证码头文件
#import <SMS_SDK/SMSSDK.h>
@interface MobManager : NSObject

-(void)sharp:(NSMutableDictionary *)data view:(UIView*)view;

//发送验证码
-(void)sendSMScode:(NSString*)ccode phone:(NSString *)phone;

@end
