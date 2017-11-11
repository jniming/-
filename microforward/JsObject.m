//
//  JsObject.m
//  microforward
//
//  Created by 张小明 on 2017/8/2.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "JsObject.h"

#import "UUIDManager.h"

#import <UIKit/UIKit.h>

#import "Constans.h"
@implementation JsObject

-(NSString*)jsToAction:(NSString *)type ccode:(NSString *)ccode phone:(NSString *)phone info:(NSString *)info qqgroup:(NSString *)qqinfo{

    int tp=[type intValue];
    
    
    if(tp==1){ //分享
        NSMutableDictionary *dir=[self dictionaryWithJsonString:info];
        
//     NSMutableDictionary  * dir=[[NSMutableDictionary alloc]init];
//        
//        [dir setObject:@"title" forKey:@"title"];
//        [dir setObject:@"分享内容 http://www.mob.com" forKey:@"text"];
//        [dir setObject:@"http://www.mob.com" forKey:@"linkUrl"];
//        [dir setObject:@"http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg" forKey:@"titleUrl"];
        
        if(dir==nil){ //分享失败
            return @"";
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"sharp" object:dir];
        
    }else if(tp==2){
        NSMutableDictionary  *dir=[[NSMutableDictionary alloc]init];
        [dir setObject:ccode forKey:@"ccode"];
        [dir setObject:phone forKey:@"phone"];
        

        [[NSNotificationCenter defaultCenter]postNotificationName:@"sendcode" object:dir];
    
    }else if(tp==3){  //加入qq群
        NSMutableDictionary *dir=[self dictionaryWithJsonString:qqinfo];
        
        NSString *group=dir[@"group"];
             NSString *key=dir[@"key"];
        
        
        [self joinGroup:group key:key];
    }
    
    return [self getuuid];
}
- (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", groupUin,key];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else return NO;
}

//字符串转字典
- (NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

//获取手机序列号
-(NSString *)getuuid{
    [UUIDManager deleteUUID];
    NSString *str=[UUIDManager getUUID];
    
//    NSDate *date=[[NSDate alloc]init];
//     NSTimeInterval time17= [date timeIntervalSince1970]*1000;
//    NSString *time=[NSString stringWithFormat:@"%f",time17];

    NSLog(@"getuuid-->%@",str);
    
    
    
    return str;
}

@end
