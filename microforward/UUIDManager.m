//
//  UUIDManager.m
//  microforward
//
//  Created by 张小明 on 2017/8/9.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "UUIDManager.h"
#import "KeyChainManager.h"
static NSString * const KEY_IN_KEYCHAIN = @"com.mas.microforward.uuid";
@implementation UUIDManager
+(void)saveUUID:(NSString *)uuid
{
    if (uuid && uuid.length > 0) {
        [KeyChainManager save:KEY_IN_KEYCHAIN data:uuid];
    }
}

+(NSString *)getUUID
{
    NSString *uuid = [KeyChainManager load:KEY_IN_KEYCHAIN];
    
    if (!uuid || uuid.length == 0) {
        uuid = [[NSUUID UUID] UUIDString];
        
        [self saveUUID:uuid];
    }
    return uuid;
}

+(void)deleteUUID
{
    [KeyChainManager delete:KEY_IN_KEYCHAIN];
}
@end
