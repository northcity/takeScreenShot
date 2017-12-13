//
//  UIView+Extension.h
//  takeScreenShot
//
//  Created by chenxi on 2017/12/13.
//  Copyright © 2017年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 *    @brief    center.x简写.
 *  赋值后,center.x = centerX.
 */
@property (nonatomic) CGFloat centerX;

/**
 *    @brief    center.y简写.
 *  赋值后, center.y = centerY.
 */
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat height;
@end
