//
//  ShareContainer.m
//  shareViewTest
//
//  Created by 北城 on 16/2/26.
//  Copyright © 2016年 P&C. All rights reserved.
//
#import "BCMARShareView.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"

@interface BCMARShareView()
//背景图片
@property (nonatomic, retain)UIView *bgView;
@property (nonatomic, retain)UIView * inforshareIconview;
@property (nonatomic, retain)UIButton *shareCancelBtn;
@property(nonatomic,strong)UIImageView *imgView;

@end
@implementation BCMARShareView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.bgView];
        [self addSubview:self.inforshareIconview];
        [self addSubview:self.shareCancelBtn];
        [self initShareContainer];
    }
    return self;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = PNCColorWithHex(0x000000);
        _bgView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgCancel)];
        [self.bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(UIView *)inforshareIconview{
    if (!_inforshareIconview) {
        //分享items view
        _inforshareIconview=[[UIView alloc]initWithFrame:CGRectMake(0,self.bounds.size.height, self.bounds.size.width, 280)];
        _inforshareIconview.layer.cornerRadius = 3.5f;
        _inforshareIconview.backgroundColor = [UIColor whiteColor];
    }
    return _inforshareIconview;
}

-(UIButton *)shareCancelBtn{
    
    if (!_shareCancelBtn) {
        _shareCancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _shareCancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,self.inforshareIconview.bottom, self.frame.size.width, 50)];
        [_shareCancelBtn setCenter:CGPointMake(self.bounds.size.width/2, self.shareCancelBtn.center.y)];
        [_shareCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_shareCancelBtn setTitleColor:BlueButtonColor forState:UIControlStateNormal];
        [_shareCancelBtn.titleLabel setFont:ButtonTitleFont];
        _shareCancelBtn.layer.borderColor = LineColor.CGColor;
        _shareCancelBtn.layer.borderWidth = 0.5f;
        _shareCancelBtn.tag = arshareTypeToCancel;
        _shareCancelBtn.backgroundColor = PNCColorWithHex(0xffffff);
        [_shareCancelBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareCancelBtn;
    
}

-(void)initShareContainer{
    
    NSArray *imgArray=[[NSArray alloc]initWithObjects:@"WX.png", @"WXPYQ.png",@"QQ.png",@"QQZone.png",@"WEIBO.png",@"SMS.png",@"MAIL.png", nil];
    NSArray *titlearray=[[NSArray alloc]initWithObjects:@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"新浪微博",@"短信",@"邮件", nil];
    
    for (NSInteger i=0; i<imgArray.count; i++) {
        
        CGFloat maginWidth=(ScreenWidth-50*4)/8.0;
        
        UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [iconBtn setFrame:CGRectMake(maginWidth+(50+2*maginWidth)*(i%4),35+123*(i/4),50, 50)];
        [iconBtn setBackgroundImage:[UIImage imageNamed:[imgArray objectAtIndex:i]]  forState:UIControlStateNormal];
        [iconBtn setTag:i+1000];
        [iconBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.inforshareIconview addSubview:iconBtn];
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0,0,60,36)];
        titlelab.center = CGPointMake(iconBtn.center.x, iconBtn.center.y+13+25+13);
        titlelab.text=[titlearray objectAtIndex:i];
        titlelab.textAlignment=NSTextAlignmentCenter;
        titlelab.font=SecondTextFont;
        titlelab.textColor = SecondTextColor;
        [self.inforshareIconview addSubview:titlelab];
    }
}

#pragma mark - 分享
- (void)share{
//    if ([_model.shareType isEqualToString:@"WeChatFriend"]) {
//        [self shareToWeiChatFriend];
//    }else if ([_model.shareType isEqualToString:@"WeChatZone"]){
//        [self shareToWeiChatFriendcircle];
//    }else if ([_model.shareType isEqualToString:@"QQFriend"]){
//        [self shareToQQFriend];
//    }else if ([_model.shareType isEqualToString:@"QQzone"]){
//        [self shareToQQZone];
//    }else if ([_model.shareType isEqualToString:@"WeiBo"]){
//        [self shareToWeiBo];
//    }else if ([_model.shareType isEqualToString:@"Message"]){
//        [self shareToMessage];
//    }else if ([_model.shareType isEqualToString:@"Mail"]){
//        [self shareToMail];
//    }else
if ([_model.shareType isEqualToString:@"More"]){
        [self show];
    }else{
        [self show];
    }
}

#pragma mark - 分享点击方法
-(void)shareBtnClick:(id)sender
{
    [self hide];
    
    UIButton * btn =(UIButton*)sender;
    ARShareType shareType = btn.tag;
//
//    switch (shareType) {
//            //微信好友
//        case arshareTypeToWeChatFriend:
//            [self shareToWeiChatFriend];
//            break;
//            //微信朋友圈
//        case arshareTypeToWeChatZone:
//            [self shareToWeiChatFriendcircle];
//            break;
//            //QQ好友
//        case arshareTypeToQQFriend:
//            [self shareToQQFriend];
//            break;
//            //QQ空间
//        case arshareTypeToQQzone:
//            [self shareToQQZone];
//            break;
//        case arshareTypeToWeiBo:
//            [self shareToWeiBo];
//            break;
//        case arshareTypeToMessage:
//            [self shareToMessage];
//            break;
//        case arshareTypeToMail:
//            [self shareToMail];
//            break;
//        case arshareTypeToCancel:
//            [self shareCancel];
//        default:
//
//            break;
//    }
}
#pragma mark - 点击背景取消数据采集
- (void)clickBgCancel{
    [self hide];
    [self shareCancel];
}
#pragma mark - 取消
-(void)shareCancel{
    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,_model.pageUrl];
//    [self EventCollectEventTpye:@"FX000330" isSuccess:@"1" remark:remarkStr resultEventType:@""];
}

#pragma mark - 显示
- (void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView * aView in window.subviews) {
        if ([aView isKindOfClass:[BCMARShareView class]]) {
            //            [aView removeFromSuperview];
            return;
        }
    }
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.4;
        self.inforshareIconview.top = self.height-330;
        self.shareCancelBtn.top = self.inforshareIconview.bottom;
    }];
}

#pragma mark - 隐藏
- (void)hide{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0;
        self.inforshareIconview.top = self.height;
        self.shareCancelBtn.top = self.inforshareIconview.bottom;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//通过大小改变大小
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGFloat)newSize{
    CGFloat W = image.size.width;
    CGFloat H = image.size.height;
    CGFloat scaleFactorW = newSize / W;
    CGFloat scaleFactorH = newSize / H;
    CGFloat scaleFactor = MIN(scaleFactorH, scaleFactorW);
    CGFloat newW = W * scaleFactor;
    CGFloat newH = H * scaleFactor;
    
    if (W < newSize || H < newSize) {
        return image;
    }
    CGSize size = CGSizeMake(newW, newH);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//
//#pragma mark -- 微信好友
//-(void)shareToWeiChatFriend{
//    
//    NSString * pageUrl = _model.pageUrl;
//    NSString * title = _model.title;
//    NSString * desc = _model.desc;
//    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,pageUrl];
//    NSString *eventTpyeStr = @"FX000328";;
//    NSString *resultEventType = @"FX000331";;
//    __block NSString *isSuccess;
//    NSString *requestChanType = @"0";//分享渠道，0：好友，1：朋友圈
//    NSString *requestRemark = @"";
//    
//    //    如果微信安装了
//    if(![WXApi isWXAppInstalled])
//    {
//        UIWindow *window=[UIApplication  sharedApplication].keyWindow;
//        [MoreAlertViewUtil showAlertTipsView:NO image:@"wonderIconPop.png" onView:window message:@"您未安装微信"];
//        isSuccess = @"0";
//        remarkStr = [remarkStr AppendString:@"未安装微信"];
//        requestRemark = @"未安装微信";
//        [self requestEventCollectIsSuccess:isSuccess shareFromPageUrl:_model.rootPageUrl shareToPageUrl:pageUrl shareChanType:requestChanType remark:requestRemark];
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }else{
//        // 初始化消息
//        WXMediaMessage *message = [WXMediaMessage message];
//        message.title = title;
//        message.description = desc;
//        
//        UIImage *suoLueTuImage = [UIImage imageWithData:_model.imageData];
//        UIImage *yaSuoHouImage = [self imageWithImage:suoLueTuImage scaledToSize:200];
//        if (UIImagePNGRepresentation(yaSuoHouImage).length/1024 > 32) {
//            yaSuoHouImage = [self imageWithImage:yaSuoHouImage scaledToSize:100];
//        }
//        [message setThumbImage:yaSuoHouImage];
//        //初始化图片对象
//        WXImageObject *imageObj = [WXImageObject object];
//        imageObj.imageData = _model.imageData;
//        message.mediaObject = imageObj;
//        
//        //        发送消息
//        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//        req.message = message;
//        req.bText = NO;
//        req.scene = WXSceneSession;
//        if ([WXApi sendReq:req]) {
//            isSuccess = @"1";
//        }else{
//            isSuccess = @"0";
//        }
//        //        数据采集
//        [self requestEventCollectIsSuccess:isSuccess shareFromPageUrl:_model.rootPageUrl shareToPageUrl:pageUrl shareChanType:requestChanType remark:requestRemark];
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }
//}
//
//#pragma mark -- 微信朋友圈
//-(void)shareToWeiChatFriendcircle{
//    
//    NSString * pageUrl = _model.pageUrl;
//    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,pageUrl];
//    NSString *eventTpyeStr = @"FX000329";
//    NSString *resultEventType = @"FX000332";
//    __block NSString *isSuccess;
//    NSString *requestChanType = @"1";//分享渠道，0：好友，1：朋友圈
//    NSString *requestRemark = @"";
//    if(![WXApi isWXAppInstalled])
//    {
//        UIWindow *window=[UIApplication  sharedApplication].keyWindow;
//        [MoreAlertViewUtil showAlertTipsView:NO image:@"wonderIconPop.png" onView:window message:@"您未安装微信"];
//        isSuccess = @"0";
//        remarkStr = [remarkStr AppendString:@"未安装微信"];
//        requestRemark = @"未安装微信";
//        [self requestEventCollectIsSuccess:isSuccess shareFromPageUrl:_model.rootPageUrl shareToPageUrl:pageUrl shareChanType:requestChanType remark:requestRemark];
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }else{
//        
//        NSString * title = _model.title;
//        NSString * desc = _model.desc;
//        NSString  *imgurl = _model.imageUrl;
//        //朋友圈
//        WXMediaMessage *message = [WXMediaMessage message];
//        message.title = title;
//        message.description = desc;
////        压缩缩略图（缩略图过大微信不让发送30k，真正图片内容不受影响最大10M）
//        UIImage *suoLueTuImage = [UIImage imageWithData:_model.imageData];
//        UIImage *yaSuoHouImage = [self imageWithImage:suoLueTuImage scaledToSize:200];
//        if (UIImagePNGRepresentation(yaSuoHouImage).length/1024 > 32) {
//            yaSuoHouImage = [self imageWithImage:yaSuoHouImage scaledToSize:100];
//        }
//
//        [message setThumbImage:yaSuoHouImage];
//        // 图片对象
//        WXImageObject *imageObj = [WXImageObject object];
//        imageObj.imageData = _model.imageData;
//        message.mediaObject = imageObj;
//        //        发送朋友圈
//        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//        req.message = message;
//        req.bText = NO;
//        req.scene = WXSceneTimeline;
//        if ([WXApi sendReq:req]) {
//            isSuccess = @"1";
//        }else{
//            isSuccess = @"0";
//        }
//        [self requestEventCollectIsSuccess:isSuccess shareFromPageUrl:_model.rootPageUrl shareToPageUrl:pageUrl shareChanType:requestChanType remark:requestRemark];
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }
//}
//
//#pragma mark -- QQ 好友
//-(void)shareToQQFriend{
//    NSString * pageUrl = _model.pageUrl;
//    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,pageUrl];
//    NSString *eventTpyeStr = @"FX000555";
//    NSString *resultEventType = @"FX000560";
//    NSString *isSuccess;
//    
//    if(![TencentOAuth iphoneQQInstalled]){
//        UIWindow *window=[UIApplication  sharedApplication].keyWindow;
//        [MoreAlertViewUtil showAlertTipsView:NO image:@"wonderIconPop.png" onView:window message:@"您未安装QQ"];
//        remarkStr = [remarkStr AppendString:@"未安装QQ"];
//        isSuccess = @"0";
//    }else{
//        NSString  *imgurl = _model.imageUrl;
//        NSString * title = _model.title;
//        NSString * desc = _model.desc;
//        //创建分享图片数组
//        NSArray *imgArray = [NSArray arrayWithObject:_model.imageData];
//        //       创建图片对象
//        QQApiImageObject *newsObj = [[QQApiImageObject alloc]initWithData:_model.imageData
//                                                         previewImageData:_model.imageData
//                                                                    title:title
//                                                              description:desc];
//        newsObj.shareDestType=ShareDestTypeQQ;
//        
//        
//        UIImage *suoLueTuImage = [UIImage imageWithData:_model.imageData];
//        UIImage *yaSuoHouImage = [self imageWithImage:suoLueTuImage scaledToSize:200];
//        if (UIImagePNGRepresentation(yaSuoHouImage).length/1024 > 32) {
//            yaSuoHouImage = [self imageWithImage:yaSuoHouImage scaledToSize:100];
//        }
//        newsObj.previewImageData = UIImagePNGRepresentation(yaSuoHouImage);
//        
//        [newsObj setCflag:0];
//        //        发送QQ消息
//        SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent: newsObj];
//        [QQApiInterface sendReq:req];
//        //         数据采集
//        isSuccess = @"1";
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }
//}
//
//
//
//#pragma mark -- QQ 空间
//-(void)shareToQQZone{
//    
//    NSString * pageUrl = _model.pageUrl;
//    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,pageUrl];
//    NSString *eventTpyeStr = @"FX000556";
//    NSString *resultEventType = @"FX000561";
//    NSString *isSuccess;
//    if(![TencentOAuth iphoneQQInstalled])
//    {
//        UIWindow *window=[UIApplication  sharedApplication].keyWindow;
//        [MoreAlertViewUtil showAlertTipsView:NO image:@"wonderIconPop.png" onView:window message:@"您未安装QQ"];
//        remarkStr = [remarkStr AppendString:@"未安装QQ"];
//        isSuccess = @"0";
//    }else{
//        NSString  *imgurl = _model.imageUrl;
//        NSString * title = _model.title;
//        NSString * desc = _model.desc;
//        NSArray *imgArray = [NSArray arrayWithObject:_model.imageData];
//        QQApiImageArrayForQZoneObject *imgObj = [[QQApiImageArrayForQZoneObject alloc]initWithImageArrayData:imgArray title:title];
//        imgObj.shareDestType = arshareTypeToQQzone;
//        //            发说说
//        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
//        [QQApiInterface SendReqToQZone:req];
//        
//        isSuccess = @"1";
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }
//}
//
//#pragma mark -- 新浪微博
//-(void)shareToWeiBo{
//    NSString * pageUrl = _model.pageUrl;
//    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,pageUrl];
//    NSString *eventTpyeStr = @"FX000557";
//    NSString *resultEventType = @"FX000562";
//    __block NSString *isSuccess;
//    
//    if(![WeiboSDK isWeiboAppInstalled]){
//        UIWindow *window=[UIApplication  sharedApplication].keyWindow;
//        [MoreAlertViewUtil showAlertTipsView:NO image:@"wonderIconPop.png" onView:window message:@"您未安装新浪微博"];
//        remarkStr = [remarkStr AppendString:@"未安装新浪微博"];
//        isSuccess = @"0";
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }else{
//        NSString  *imgurl = _model.imageUrl;
//        NSString * title = _model.title;
//        NSString * desc = _model.desc;
//        // 消息的图片内容中，图片数据不能为空并且大小不能超过10M
//        
//        //        微博的图片对象
//        WBImageObject *imageObject = [WBImageObject object];
//        imageObject.imageData = _model.imageData;
//        //        发微博的message
//        WBMessageObject *message=[WBMessageObject message];
//        message.text= [NSString stringWithFormat:@"%@\n%@ %@", title,desc,pageUrl];
//        message.imageObject = imageObject;
//        //        发微博请求
//        WBSendMessageToWeiboRequest *requete=[WBSendMessageToWeiboRequest requestWithMessage:message];
//        BOOL sendOK = [WeiboSDK sendRequest:requete];
//        if (sendOK) {
//            isSuccess = @"1";
//        }else{
//            isSuccess = @"0";
//        }
//        //        数据采集
//        [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:resultEventType];
//    }
//}
//
//#pragma mark -- 短信
//-(void)shareToMessage{
//    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,_model.pageUrl];
//    NSString *eventTpyeStr = @"FX000558";
//    NSString *isSuccess;
//    
//    if ([MFMessageComposeViewController canSendText]){
//        
//        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
//        //短信内容
//        messageVC.body =[NSString stringWithFormat:@"%@ %@ %@",_model.title,_model.desc,_model.pageUrl];
//        messageVC.messageComposeDelegate = self;
//        [messageVC addAttachmentData:_model.imageData typeIdentifier:@"image.png" filename:@"image.png"];
//        //获取当前控制器
//        UINavigationController *rootVC = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
//        UIViewController *currentVC = [[rootVC viewControllers] lastObject];
//        [currentVC presentViewController:messageVC animated:YES completion:nil];
//        isSuccess = @"1";
//    }else{
//        UIWindow *window=[UIApplication  sharedApplication].keyWindow;
//        [MoreAlertViewUtil showAlertTipsView:NO image:@"wonderIconPop.png" onView:window message:@"设备无法发送短信"];
//        isSuccess = @"0";
//    }
//    [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:@""];
//}
//
//-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
//    [controller dismissViewControllerAnimated:YES completion:^{
//        NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,_model.pageUrl];
//        NSString *resultEventType = @"FX000563";
//        NSString *isSuccess;
//        switch (result) {
//            case MessageComposeResultSent:
//                //信息传送成功
//                isSuccess = @"1";
//                [MoreAlertViewUtil showMyOneBtnAlert:@"分享成功" buttonTitle:@"确定" ];
//                break;
//            default:
//                isSuccess = @"0";
//                [MoreAlertViewUtil showMyOneBtnAlert:@"分享失败" buttonTitle:@"确定" ];
//                break;
//        }
//        [self EventCollectEventTpye:resultEventType isSuccess:isSuccess remark:remarkStr resultEventType:@""];
//    }];
//}
//
//#pragma mark -- 邮件
//-(void)shareToMail{
//    NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,_model.pageUrl];
//    NSString *eventTpyeStr = @"FX000559";
//    NSString *isSuccess;
//    // 如果能发送邮件
//    if ([MFMailComposeViewController canSendMail]){
//        // 创建MFMailComposeViewController对象
//        MFMailComposeViewController * mailViewController =[[MFMailComposeViewController alloc] init];
//        // 设置邮件主题
//        mailViewController.subject = _model.title;
//        mailViewController.mailComposeDelegate=self;
//        NSString *contentStr=[NSString stringWithFormat:@"%@ %@",_model.desc,_model.pageUrl];
//        [mailViewController addAttachmentData:_model.imageData mimeType:@"image.png" fileName:@"image.png"];
//        // 设置邮件正文
//        [mailViewController setMessageBody:contentStr isHTML:NO];
//        //获取当前控制器
//        UINavigationController *rootVC = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
//        UIViewController *currentVC = [[rootVC viewControllers] lastObject];
//        [currentVC presentViewController:mailViewController animated:YES completion:nil];
//        isSuccess = @"1";
//    } else{
//        isSuccess = @"0";
//        UIWindow *window=[UIApplication  sharedApplication].keyWindow;
//        [MoreAlertViewUtil showAlertTipsView:NO image:@"wonderIconPop.png" onView:window message:@"设备无法发送邮件"];
//    }
//    [self EventCollectEventTpye:eventTpyeStr isSuccess:isSuccess remark:remarkStr resultEventType:@""];
//}
//
//- (void)mailComposeController:(MFMailComposeViewController *)controller
//          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
//    [controller dismissViewControllerAnimated:YES completion:^{
//        
//        NSString *remarkStr =[NSString stringWithFormat:@"%@;%@;",_model.rootPageUrl,_model.pageUrl];
//        NSString *resultEventType = @"FX000564";
//        NSString *isSuccess;
//        switch (result) {
//            case MFMailComposeResultSent:
//                isSuccess = @"1";
//                [MoreAlertViewUtil showMyOneBtnAlert:@"分享成功" buttonTitle:@"确定" ];
//                break;
//            default:
//                isSuccess = @"0";
//                [MoreAlertViewUtil showMyOneBtnAlert:@"分享失败" buttonTitle:@"确定" ];
//                break;
//        }
//        [self EventCollectEventTpye:resultEventType isSuccess:isSuccess remark:remarkStr resultEventType:@""];
//    }];
//}
//

@end

