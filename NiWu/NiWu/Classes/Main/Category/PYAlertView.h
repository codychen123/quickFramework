//
//  PYAlertView.h
//  PEB
//
//  Created by hxt_025 on 2017/3/31.
//  Copyright © 2017年 peb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYAlertView : UIView

+ (instancetype)sharedInstance;

/**
 只显示信息
 @param message 要显示的内容
 */
- (void)showMessage:(NSString *)message;

/**
 可现实detail信息
 @param message 显示的信息
 @param detailMessage 细节信息
 */
- (void)showMessage:(NSString *)message detailMessage:(NSString *)detailMessage;

/**
 显示带图片的信息
 @param message 信息内容
 @param imageName 图片名称
 */
- (void)showMessage:(NSString *)message customView:(NSString *)imageName;


/**
 显示加载进度
 @param message 信息内容
 @param progress 进度
 */
- (void)showloadingAnimationWithProgressMessage:(NSString *)message progress:(CGFloat)progress;

/**
 加载中
 */
- (void)showloadingAnimationWithProgressMessage:(NSString *)message ;

/*
 弹出
 */
- (void)dismiss;

@end
