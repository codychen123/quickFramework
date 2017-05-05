//
//  UIButton+HH.h
//  PEB
//
//  Created by xiaohuihui on 2017/3/4.
//  Copyright © 2017年 peb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HH)

/**
 *  快速创建一个UIButton对象 通过给定的图片
 */
+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                             target:(id)target
                             action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                    diableColor:(UIColor *)diableColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action;


+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                     touchBlock:(void(^)())block;
/**
 *  快速创建一个UIButton对象 通过给定的图片
 */
+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                         touchBlock:(void(^)())block;



/**
 设置按钮样式

 @param color 背景颜色
 @param cornerRadius 圆角
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param target 所属控件
 @param action 调用方法
 */
- (void)setButtonStyleWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius
                    borderWidth:(CGFloat)borderWidth
                    borderColor:(UIColor *)borderColor
                         target:(id)target
                         action:(SEL)action;




/**
 * 设置默认按钮样式
 */
- (void)setDefualtButtonStyle ;

/**
 * 设置空心按钮样式
 */
- (void)setHollowButtonStyle ;
@end
