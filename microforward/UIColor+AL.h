//
//  UIColor+AL.h
//  ALFrameProject
//
//  Created by 张小明 on 2017/7/15.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
@interface UIColor (AL)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 创建颜色图片

 @param color 16进制颜色值
 @return 返回图片
 */
+(UIImage*) createImage:(NSString*) color;
@end
