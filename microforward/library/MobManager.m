//
//  MobManager.m
//  microforward
//
//  Created by 张小明 on 2017/8/3.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "MobManager.h"
#import <MBProgressHUD.h>
@implementation MobManager
-(void)sharp:(NSMutableDictionary *)data view:(UIView *)view{
    
    NSDictionary *infoData= data;
    
    NSString *title=infoData[@"title"];
    
    NSString *titleUri=infoData[@"titleUri"];
    
    NSString *text=infoData[@"text"];
    
    NSString *linkUrl=infoData[@"linkUrl"];
    
    NSLog(@"title-->%@,titleUri-->%@,text-->%@,linkUrl-->%@",title,titleUri,text,linkUrl);
    
    if(titleUri ==nil){
       titleUri=@"";
    }
    if(title==nil){
       title=@"";
    }
    if(text==nil){
    text=@"";
    }
    if(linkUrl==nil){
      linkUrl=@"";
    }
   
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:titleUri
                                        url:[NSURL URLWithString:linkUrl]
                                      title:title
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateBegin:{  //开始分享
                           [MBProgressHUD showHUDAddedTo:view animated:YES];
                           break;
                       
                       }
                     
                       case SSDKResponseStateCancel:{  //分享取消
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                           
                       }
                           
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   
                   if (state != SSDKResponseStateBegin && state != SSDKResponseStateBeginUPLoad)
                   {
                       [MBProgressHUD hideHUDForView:view animated:YES];
//                       [theController showLoadingView:NO];
//                       [theController.tableView reloadData];
                   }
               }
     ];

}


-(void)sendSMScode:(NSString *)ccode phone:(NSString *)phone{
//    ccode=@"86";
//    phone=@"18665728562";
    if(![ccode isEqualToString:@""]&&![phone isEqualToString:@""]){
    }
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:ccode result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
        }
        else
        {
            // error
        }
    }];

}
@end
