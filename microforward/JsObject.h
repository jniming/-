//
//  JsObject.h
//  microforward
//
//  Created by 张小明 on 2017/8/2.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol jsexp <JSExport>
//JSExportAs 注释表示js调用的方法一定是从JSExportAs注释的方法中去轮询查找,防止出现多个方法名相同而不知道是哪个的冲突
//第一个参数表示js中的方法名,一般我们写的和我们的第二个参数的方法名一样
//第二个参数是实际要执行的方法
JSExportAs(jsToAction,-(NSString *)jsToAction:(NSString *)type ccode:(NSString *)ccode phone:(NSString*)phone info:(NSString*)info) qqgroup:(NSString *)qqinfo;

@end

@interface JsObject : NSObject<jsexp>

-(NSString*)jsToAction:(NSString*)type ccode:(NSString *)ccode phone:(NSString *)phone info:(NSString *)info qqgroup:(NSString *)qqinfo;



@end
