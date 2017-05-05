//
//  UIView+TL.h
//  
//
//  Created by admin on 15/10/20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TL)
@property (nonatomic , assign ) CGFloat width;
@property (nonatomic , assign ) CGFloat height;
@property (nonatomic , assign ) CGFloat x;
@property (nonatomic , assign ) CGFloat y;
@property (nonatomic , assign ) CGSize size;
@property (nonatomic , assign ) CGFloat centerX;
@property (nonatomic , assign ) CGFloat centerY;

/**
 *  设置顶部圆角
 */
- (void)setCornerOnTop;

/**
 *  设置底部圆角
 */
- (void)setCornerOnBottom;

/**
 *  设置全部圆角
 */
- (void)setAllCorner;

/**
 *  设置自定义圆角
 */
- (void)setCustomCornerByRadius:(CGFloat)radius;

/**
 *  设置无圆角
 */
- (void)setNoneCorner;


+ (UIViewController *)getCurrentVC;
@end
