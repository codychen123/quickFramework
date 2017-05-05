/*!
 @header      MBProgressHUD+PY.h
 @abstract    加载视图
 @author      Created by 汪特龙 on 16/4/19
 @version     16/4/19
 Copyright © 2016年 peb. All rights reserved.
 */

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (PY)

/**
 *  隐藏加载视图
 *
 *  @param view 视图对象
 */
+ (void)hideHUDForView:(UIView *)view;

/**
 *  隐藏加载视图
 */
+ (void)hideHUD;


+ (void)showLoadingView;
/**
 *  显示纯文字加载框
 *
 *  @param message 文字信息
 *  @param view    加载视图
 */
+ (void)showOnlyMessage:(NSString *)message toView:(UIView *)view;

/**
 *  显示纯文字加载框
 *
 *  @param message 文字信息
 */
+ (void)showOnlyMessage:(NSString *)message;

/**
 *  显示加载框(小菊花)
 *
 *  @param message 文字信息
 *  @param view    加载视图
 */
+ (void)showLoadingViewOnWindow:(NSString *)message toView:(UIView *)view;

/**
 *  显示一个有遮罩的加载框(小菊花)
 *
 *  @param message 文字信息
 *  @param view    加载视图
 */
+ (void)showLoadingViewHaveDim:(NSString *)message toView:(UIView *)view;


/**
 *  隐藏视图上的所有加载框
 *
 */
+ (void)hideLoadingView ;

/**
 *  隐藏视图上的所有加载框
 *
 *  @param view 视图对象
 */
+ (void)hideLoadingView:(UIView *)view;

/**
 *  显示成功提示框
 *
 *  @param message 提示信息
 *  @param view    视图对象
 */
+ (void)showSuccessView:(NSString *)message toView:(UIView *)view;


/**
 *  显示失败提示框
 *
 *  @param message 提示信息
 *  @param view    视图对象
 */
+ (void)showFailureView:(NSString *)message toView:(UIView *)view;


/**
 *  自定义加载数据
 *
 *  @param view 视图对象
 */
+ (void)showLoadingToView:(UIView *)view;
@end
