//
//  UIImageView+TL.m
//  PEB
//
//  Created by aTeLong on 17/3/20.
//  Copyright © 2017年 peb. All rights reserved.
//

#import "UIImageView+TL.h"

@implementation UIImageView (TL)
- (void)setWebImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder {
    url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    UIImage *placeImage = [UIImage imageNamed:placeholder];
    if (placeholder == nil || [placeholder isEqualToString:@""]) {
        placeImage = [self rescaleImage:[UIImage imageNamed:kPlaceHolderImageName] toSize:self.bounds.size];
    }
    
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:placeImage];
}

- (void)createQRForString:(NSString *)qrString{
    
    NSData *stringData = [qrString dataUsingEncoding: NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *qrImage = qrFilter.outputImage;
    float scaleX = self.frame.size.width                                                                                                                                                                                                                                      / qrImage.extent.size.width;
    float scaleY = self.frame.size.height / qrImage.extent.size.height;
    
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY)];
    
    self.image = [UIImage imageWithCIImage:qrImage
                                            scale:[UIScreen mainScreen].scale
                                      orientation:UIImageOrientationUp];
}



- (UIImage *)rescaleImage:(UIImage *)image toSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    UIImage *backImage = [UIImage imageWithColor:UIColorFromRGB(0xe7e7e7)];
    
    [backImage drawInRect:rect];
    
    CGFloat imageWidth  = size.width * 0.5;
    CGFloat imageHeight  = size.height * 0.5;
    
    CGFloat imageW = 0;
    if (imageWidth > imageHeight) {
        imageW = imageHeight;
    }else{
        imageW = imageWidth;
    }
    
    [image drawInRect:CGRectMake((size.width - imageW) * 0.5, (size.height - imageW) * 0.5, imageW, imageW)];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
    
}
@end
