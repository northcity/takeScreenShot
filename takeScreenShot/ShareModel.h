//
//  ShareModel.h
//  BankOfCommunications
//
//  Created by 田飞 on 2017/5/18.
//  Copyright © 2017年 P&C Information. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface ShareModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *pageUrl;
@property (nonatomic, strong) NSString *shareType;
@property (nonatomic, strong) NSString *rootPageUrl;
@property (nonatomic, strong) NSData * imageData;

-(id)initWithDict:(NSDictionary *)dict;

/**
 注册分享
 */
+(void)shareRegisterApp;
@end
