//
//  BCMARShareView.h
//  BankOfCommunications
//
//  Created by 北城 on 2017/10/30.
//  Copyright © 2017年 P&C Information. All rights reserved.
//
/*
 Taps：
         1.此类为分享图片专用类。
         2.分享图片专用，谁想用都可以。
 */

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>
#import "ShareModel.h"
#import "UIColor+Hex.h"
#import "UIView+Extension.h"
//主屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//主屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define PNCisIPHONEX  ((CGRectGetHeight([[UIScreen mainScreen] bounds]) >=812.0f)? (YES):(NO))

#define KAUTOSIZE(_wid,_hei)   CGSizeMake(_wid * ScreenWidth / 375.0, _hei * ScreenHeight / 667.0)
#define kAUTOWIDTH(_wid)  _wid * ScreenWidth / 375.0
#define kAUTOHEIGHT(_hei)      (PNCisIPHONEX ? _hei * 1 : _hei * ScreenHeight / 667.0)
#define SecondTextColor     [UIColor colorWithHex:0x999999]
#define SecondTextFont      [UIFont systemFontOfSize:13.0f]
#define BlueButtonColor     [UIColor colorWithHex:0x2072cf]
#define PNCColorWithHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ButtonTitleFont     [UIFont systemFontOfSize:16.0f]
#define LineColor           [UIColor colorWithHex:0xe8e8e8]


typedef  NS_ENUM (NSInteger,ARShareType){
    arshareTypeToWeChatFriend=1000,
    arshareTypeToWeChatZone,
    arshareTypeToQQFriend,
    arshareTypeToQQzone,
    arshareTypeToWeiBo,
    arshareTypeToMessage,
    arshareTypeToMail,
    arshareTypeToCancel
};

@interface BCMARShareView: UIView<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property(nonatomic,assign)ARShareType  shareType;
//分享内容
@property (nonatomic, strong) ShareModel *model;
//分享
- (void)share;

@end

