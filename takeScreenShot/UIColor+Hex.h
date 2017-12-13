//
//  UIColor+Hex.h
//  PNCOAForIpad
//
//  Created by 彭 小坚 on 14-1-6.
//  Copyright (c) 2014年 P&C. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (Hex)
/*
 将16进制颜色值转换为RGB值
 */
+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

/*!
 @abstract   随机取颜色值
 
 @return 颜色
 
 @since 彭小坚 2014.8.20 @HKBKCIT
 */
+ (UIColor *)randomColor;
@end

