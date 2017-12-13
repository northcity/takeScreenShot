//
//  UIView+Extension.m
//  takeScreenShot
//
//  Created by chenxi on 2017/12/13.
//  Copyright © 2017年 chenxi. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
