//
//  AppDelegate.m
//  microforward
//
//  Created by 张小明 on 2017/8/1.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>


//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"

//友盟统计
#import "UMMobClick/MobClick.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initSharpSdk];
    [self Yminit];
    MainViewController *main=[[MainViewController alloc]init];
    
    UINavigationController *na=[[UINavigationController alloc]initWithRootViewController:main];
    
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=na;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

-(void)Yminit{

    UMConfigInstance.appKey = @"5983e5e1677baa541b000483";
    UMConfigInstance.channelId = @"";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK
    
//    [MobClick setLogEnabled:YES];
}


//初始化分享sdk的配置
-(void)initSharpSdk{

    
    
    /**初始化ShareSDK应用
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
            
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
          
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx856a617fcb81246c"
                                       appSecret:@"e9f64fcd70f366320c56e2408b4f9bbd"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106252409"
                                      appKey:@"EaTwmSUDLeHvt7iw"
                                    authType:SSDKAuthTypeBoth];
                 break;
            
             default:
                 break;
         }
     }];
   
    
    
}
-(void)onResp:(BaseResp *)resp
{
    NSLog(@"The response of wechat.");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
