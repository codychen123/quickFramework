//
//  UIButton+HH.m
//  PEB
//
//  Created by xiaohuihui on 2017/3/4.
//  Copyright © 2017年 peb. All rights reserved.
//

#import "UIButton+HH.h"
#import <objc/runtime.h>

typedef void(^ActionBlock)();

@implementation UIButton (HH)

static char buttonBlockKey;

+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                             target:(id)target
                             action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (imagename) {
        
        [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    }
    if (hightImagename) {
        
        [button setImage:[UIImage imageNamed:hightImagename] forState:UIControlStateNormal];
    }
    
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    return button;
    
}

+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                         touchBlock:(void (^)())block {
    
    
    UIButton *button = [self buttonWithImagename:imagename hightImagename:hightImagename bgImagename:bgImagename target:self action:@selector(btnTouch:)];
    button.block = block;
    return button;
}

+ (void)btnTouch:(UIButton *)button {
    if (button.block) {
        button.block();
    }
}

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                     touchBlock:(void (^)())block {
    
    UIButton *button = [self buttonWithTitle:title
                                 normalColor:normalColor
                               selectedColor:selectedColor
                                    fontSize:fontSize
                                      target:self
                                      action:@selector(btnTouch:)];
    button.block = block;
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor diableColor:(UIColor *)diableColor fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor && title) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (diableColor && title) {
        [button setTitleColor:diableColor forState:UIControlStateDisabled];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor && title) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor && title) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    
    return button;
}

- (void)setBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &buttonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ActionBlock)block {
    return objc_getAssociatedObject(self, &buttonBlockKey);
}


- (void)setButtonStyleWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius
                    borderWidth:(CGFloat)borderWidth
                    borderColor:(UIColor *)borderColor
                         target:(id)target
                         action:(SEL)action {
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateDisabled];
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    [self setBackgroundColor:color];
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    if (target != nil && action != nil){
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}


/**
 * 设置默认按钮样式
 */
- (void)setDefualtButtonStyle {
    self.layer.borderColor = MAIN_RED_COLOR.CGColor;
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self setBackgroundImage:[UIImage imageWithColor:MAIN_RED_COLOR] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xaa0b1d)] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xdddddd)] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

/**
 * 设置空心按钮样式
 */
- (void)setHollowButtonStyle{
    self.layer.borderColor = MAIN_RED_COLOR.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:MAIN_RED_COLOR] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    [self setTitleColor:MAIN_RED_COLOR forState:UIControlStateNormal];
}


@end
