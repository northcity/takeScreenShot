//
//  BCMTakeScreenshotAfterShareView.m
//  BankOfCommunications_Pro
//
//  Created by 北城 on 2017/9/29.
//  Copyright © 2017年 P&C Information. All rights reserved.
//

#import "BCMTakeScreenshotAfterShareView.h"
//#import "ShareContainer.h"
#import "BCMARShareView.h"

@interface BCMTakeScreenshotAfterShareView()<UIGestureRecognizerDelegate>

/**
 分享视图
 */
//@property(nonatomic,strong) ShareContainer *shareView;

/**
 分享视图
 */
@property(nonatomic,strong) BCMARShareView *arShareView;

/**
 图片数据
 */
@property (nonatomic, strong) NSData * imageData;

/**
 合成的全局Image
 */
@property(nonatomic,strong)UIImage *heChengImage;


@end

@implementation BCMTakeScreenshotAfterShareView

BCMTakeScreenshotAfterShareView *SV = nil;

+ (void)userDidTakeScreenshot:(NSNotification *)notification{
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片,放到最前面
    UIImage *screenShotImage = [self imageWithScreenshot];
    
    SV = [[BCMTakeScreenshotAfterShareView alloc]init];
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    
//    二维码ImageView
    UIImageView *QRImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIView *QRBackView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-kAUTOWIDTH(134), ScreenHeight-kAUTOHEIGHT(159), kAUTOWIDTH(110), kAUTOHEIGHT(110))];
    QRBackView.backgroundColor = [UIColor whiteColor];
    UIImageView *imgQR = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, kAUTOWIDTH(101), kAUTOHEIGHT(101))];
    imgQR.center = QRBackView.center;
    imgQR.image =  [SV generateQRCode:@"https://cc.bankcomm.com/ARsha1" width:101 height:101];
    imgQR.backgroundColor =[UIColor redColor];
    
    UILabel *QRLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - kAUTOWIDTH(227), ScreenHeight-kAUTOHEIGHT(39), kAUTOWIDTH(200), kAUTOHEIGHT(20))];
    QRLabel.text = @"扫码玩AR";
    QRLabel.font = [UIFont systemFontOfSize:16];
    QRLabel.textColor = [UIColor whiteColor];
    [SV changeWordSpaceForLabel:QRLabel WithSpace:kAUTOWIDTH(8)];
    QRLabel.frame = CGRectMake(ScreenWidth - QRLabel.frame.size.width - kAUTOWIDTH(37), ScreenHeight-kAUTOHEIGHT(39), QRLabel.frame.size.width-kAUTOWIDTH(8),QRLabel.frame.size.height);
    QRLabel.centerX = imgQR.centerX;
    QRLabel.textAlignment = NSTextAlignmentCenter;

    [QRImageView addSubview:QRBackView];
    [QRImageView addSubview:imgQR];
    [QRImageView addSubview:QRLabel];

//    截图之后显示的View
    UIView *afterShareView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-kAUTOWIDTH(100), kAUTOHEIGHT(272),kAUTOWIDTH(90) ,kAUTOHEIGHT(130))];
    afterShareView.backgroundColor = [UIColor colorWithHex:0x222222 alpha:0.85f];
    afterShareView.layer.shadowRadius = 5.f;
    
    afterShareView.layer.shadowOffset = CGSizeMake(0, 0);
    afterShareView.layer.shadowColor = [UIColor colorWithHex:0x222222].CGColor;
    afterShareView.layer.shadowOpacity = 0.5;
    afterShareView.layer.shadowRadius = 7.5f;
    afterShareView.layer.cornerRadius = 2;
    
    UIButton *shareBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0,afterShareView.frame.size.height- kAUTOHEIGHT(30) , afterShareView.frame.size.width,kAUTOHEIGHT(30));
    [shareBtn setTitle:@"分享页面" forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:11.f];
    [shareBtn setTitleColor:[UIColor colorWithHex:0xffffff] forState:UIControlStateNormal];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, kAUTOWIDTH(20), 0, 0);
    
    UIImageView *butImage = [[UIImageView alloc]initWithFrame:CGRectMake(kAUTOWIDTH(14), kAUTOHEIGHT(8), kAUTOWIDTH(14), kAUTOHEIGHT(14))];
    [shareBtn addSubview:butImage];
    butImage.image =[UIImage imageNamed:@"fen.png"];
    
//    把二维码的View变成Image
    UIImage *QRImage = [SV CanBecomeFromUIImageView:QRImageView];
    SV.heChengImage = [SV combineQrImage:screenShotImage withQRImage:QRImage];  //合成之后的Image
    
    //添加显示
    UIImageView *imgPhoto = [[UIImageView alloc]initWithImage:screenShotImage];
    imgPhoto.frame = CGRectMake(kAUTOWIDTH(4),kAUTOHEIGHT(4) , kAUTOWIDTH(82), kAUTOHEIGHT(96));
    imgPhoto.contentMode = UIViewContentModeScaleAspectFill;
    imgPhoto.layer.masksToBounds = YES;
    imgPhoto.tag = 110;
    
    [afterShareView addSubview:imgPhoto];
    [afterShareView addSubview:shareBtn];

    [win addSubview:afterShareView];
    
    [shareBtn addTarget:SV action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [afterShareView removeFromSuperview];
    });
    
}


- (void)shareBtnAction{
//    self.shareView = [[ShareContainer alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.arShareView = [[BCMARShareView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//
    ShareModel *model = [[ShareModel alloc] init];
//    model.title = @";
//    model.desc = @"";
//    model.pageUrl = @"";
//    model.imageUrl = @"";
//    model.rootPageUrl = @"";

//    UIImage *newImag = [self imageWithImage:SV.heChengImage scaledToSize:736];

    
    _imageData = UIImagePNGRepresentation(SV.heChengImage);

//    if (!_imageData) {
//        UIImage * image = [UIImage imageNamed:@"BCMShareDefault"];
//        _imageData = UIImagePNGRepresentation(image);
//    }
    model.imageData = _imageData;
    self.arShareView.model = model;
    [self.arShareView share];
}

//获取截图ImageData
+ (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }else{
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}
//通过大小改变大小
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGFloat)newSize
{
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

// 通过改变像素点改变体积
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//把截图的ImageData转变成UIImage
+ (UIImage *)imageWithScreenshot{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

#pragma mark - 生成二维码
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

//改变字间距
- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
//改变行间距
- (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
//改变行间距和字间距
- (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
}

#pragma mark - 合并图片
- (UIImage*)combineQrImage:(UIImage*)aQrImage withQRImage:(UIImage*)QRImage {
    CGSize qrImageSize = aQrImage.size;
    UIGraphicsBeginImageContext(qrImageSize);
    [aQrImage drawInRect:CGRectMake(0, 0, qrImageSize.width, qrImageSize.height)];
    [QRImage drawInRect:CGRectMake(0, 0, qrImageSize.width, qrImageSize.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark 把imageView变成Image
- (UIImage*)CanBecomeFromUIImageView:(UIImageView *)qrimageView{
    CGSize QRImageSize = qrimageView.frame.size;
    UIGraphicsBeginImageContext(QRImageSize);
    [qrimageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *QRImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return QRImage;
}


@end
