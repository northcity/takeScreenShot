//
//  BCMTakeScreenshotAfterShareView.h
//  BankOfCommunications_Pro
//
//  Created by 北城 on 2017/9/29.
//  Copyright © 2017年 P&C Information. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"
#import "UIView+Extension.h"
#import "ShareModel.h"
//主屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//主屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define PNCisIPHONEX  ((CGRectGetHeight([[UIScreen mainScreen] bounds]) >=812.0f)? (YES):(NO))

#define KAUTOSIZE(_wid,_hei)   CGSizeMake(_wid * ScreenWidth / 375.0, _hei * ScreenHeight / 667.0)
#define kAUTOWIDTH(_wid)  _wid * ScreenWidth / 375.0
#define kAUTOHEIGHT(_hei)      (PNCisIPHONEX ? _hei * 1 : _hei * ScreenHeight / 667.0)


@interface BCMTakeScreenshotAfterShareView : NSObject

/**
 截屏的通知操作

 @param notification 通知
 */
+ (void)userDidTakeScreenshot:(NSNotification *)notification;

/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
+ (NSData *)dataWithScreenshotInPNGFormat;

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */

+ (UIImage *)imageWithScreenshot;

/**
 通过size大小改变图片大小

 @param image 传进去的图片
 @param newSize 新的大小
 @return 传回来的图片
 */
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGFloat)newSize;

/**
 通过改变像素点改变图片的大小

 @param image 老的image
 @param size 新的大小
 @return 新的Image
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;


- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;
//改变字间距
- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
@end
