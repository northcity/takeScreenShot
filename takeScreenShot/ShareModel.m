//
//  ShareModel.m
//  BankOfCommunications
//
//  Created by 田飞 on 2017/5/18.
//  Copyright © 2017年 P&C Information. All rights reserved.
//

#import "ShareModel.h"

//微博
#import "WeiboSDK.h"
//QQ
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
@implementation ShareModel
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (key)
    {
        return;
    }
}

+(void)shareRegisterApp{
    //分享
//    [WeiboSDK enableDebugMode:YES];
//    [WeiboSDK registerApp:SinaAPPKey];
//    [WXApi registerApp:kAppWeixinKey];
//    
//    [[TencentOAuth alloc] initWithAppId:kQQKey andDelegate:nil];
}
@end
