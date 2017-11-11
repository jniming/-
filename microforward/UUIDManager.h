//
//  UUIDManager.h
//  microforward
//
//  Created by 张小明 on 2017/8/9.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUIDManager : NSObject

+(void)saveUUID:(NSString *)uuid;

+(NSString *)getUUID;

+(void)deleteUUID;
@end
