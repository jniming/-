//
//  KeyChainManager.h
//  microforward
//
//  Created by 张小明 on 2017/8/9.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainManager : NSObject
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;
@end
