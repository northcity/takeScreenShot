//
//  ViewController.m
//  takeScreenShot
//
//  Created by chenxi on 2017/12/13.
//  Copyright © 2017年 chenxi. All rights reserved.
//

#import "ViewController.h"
#import "BCMTakeScreenshotAfterShareView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //    截屏通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jiePingChuli:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)jiePingChuli:(NSNotification *)noti{
    [BCMTakeScreenshotAfterShareView userDidTakeScreenshot:noti];
    //    [[UIApplication sharedApplication]setStatusBarStyle: UIStatusBarStyleBlackOpaque];
//    [self statusBarIsLightContentStyle:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
