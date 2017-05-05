//
//  UIImageView+TL.h
//  PEB
//
//  Created by aTeLong on 17/3/20.
//  Copyright © 2017年 peb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TL)
- (void)setWebImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholder ;

//生成二维码
- (void)createQRForString:(NSString *)qrString;
@end
