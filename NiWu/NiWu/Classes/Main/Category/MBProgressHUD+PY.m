/*!
 @header      MBProgressHUD+PY.m
 @abstract    加载视图
 @author      Created by 汪特龙 on 16/4/19
 @version     16/4/19
 Copyright © 2016年 peb. All rights reserved.
 */

#import "MBProgressHUD+PY.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation MBProgressHUD (PY)
#pragma mark 显示一些信息
/**
 *  隐藏加载视图
 *
 *  @param view 视图对象
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil){
        //SDK8.0后 防止UITextEffectsWindow显示而获取不到真正window的问题
        for (int i = (int)[UIApplication sharedApplication].windows.count  - 1 ; i >= 0 ; i --) {
            view =  [UIApplication sharedApplication].windows[i];
            [self hideHUDForView:view animated:YES];
        }
    }
}

/**
 *  隐藏加载视图
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  显示纯文字加载框
 *
 *  @param message 文字信息
 *  @param view    加载视图
 */
+ (void)showOnlyMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [self getShowViewWithView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.layer.cornerRadius = 4;
    hud.detailsLabel.font = [UIFont fontWithName:LIGHTFONT size:16.f];
    hud.detailsLabel.text = message;
    // 设置图片
    hud.customView = nil;
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    // 2秒之后再消失
    [hud hideAnimated:YES afterDelay:2.0];
}


/**
 *  显示纯文字加载框
 *
 *  @param message 文字信息
 */
+ (void)showOnlyMessage:(NSString *)message
{
//    [self hideHUD];
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    [self showOnlyMessage:message toView:nil];
}


+ (void)showLoadingView
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    UIViewController *vc = [UIView getCurrentVC];
    [self showLoadingViewOnWindow:nil toView:vc.view];
}


/**
 *  显示加载框(小菊花)
 *
 *  @param message 文字信息
 *  @param view    加载视图
 */
+ (void)showLoadingViewOnWindow:(NSString *)message toView:(UIView *)view
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (view == nil) view = [self getShowViewWithView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.layer.cornerRadius = 4;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.font = [UIFont fontWithName:LIGHTFONT size:16.f];
    if (message == nil) {
        hud.detailsLabel.text = NSLocalizedString(@"正在加载...", nil);
    } else {
        hud.detailsLabel.text =  message;
    }
    [hud showAnimated:YES];
}

/**
 *  显示一个有遮罩的加载框(小菊花)
 *
 *  @param message 文字信息
 *  @param view    加载视图
 */
+ (void)showLoadingViewHaveDim:(NSString *)message toView:(UIView *)view
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (view == nil) view = [self getShowViewWithView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.dimBackground = YES;
    hud.bezelView.layer.cornerRadius = 4;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.font = [UIFont fontWithName:LIGHTFONT size:16.f];
    if (message == nil) {
        hud.detailsLabel.text = NSLocalizedString(@"正在加载...", nil);
    } else {
        hud.detailsLabel.text = message;
    }
    [hud showAnimated:YES];
}

/**
 *  隐藏视图上的所有加载框
 *
 */
+ (void)hideLoadingView {
    [self hideLoadingView:nil];
}



/**
 *  隐藏视图上的所有加载框
 *
 *  @param view 视图对象
 */
+ (void)hideLoadingView:(UIView *)view
{
    UIViewController *vc = [UIView getCurrentVC];
//    if (vc.childViewControllers > 0) {
//        for (UIViewController *childVC in vc.childViewControllers) {
//            [MBProgressHUD hideHUDForView:childVC.view animated:YES];
//        }
//    }
    [MBProgressHUD hideHUDForView:vc.view animated:YES];
    [MBProgressHUD hideHUDForView:vc.view animated:YES];
    [MBProgressHUD hideHUDForView:view animated:YES];
}

/**
 *  显示成功提示框
 *
 *  @param message 提示信息
 *  @param view    视图对象
 */
+ (void)showSuccessView:(NSString *)message toView:(UIView *)view
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (view == nil) view = [self getShowViewWithView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.layer.cornerRadius = 4;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"success.png"]]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.font = [UIFont fontWithName:LIGHTFONT size:16.f];
    hud.detailsLabel.text = message;
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0f];
}


/**
 *  显示失败提示框
 *
 *  @param message 提示信息
 *  @param view    视图对象
 */
+ (void)showFailureView:(NSString *)message toView:(UIView *)view
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (view == nil) view = [self getShowViewWithView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.layer.cornerRadius = 4;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"error.png"]]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.font = [UIFont fontWithName:LIGHTFONT size:16.f];
    hud.detailsLabel.text = message;
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.0f];
}


/**
 *  自定义加载数据
 *
 *  @param view 视图对象
 */
+ (void)showLoadingToView:(UIView *)view
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    if (view == nil) view = [self getShowViewWithView:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 设置显示和消失模式为淡入淡出
    hud.animationType = MBProgressHUDAnimationFade;
    // 设置遮罩颜色
    hud.bezelView.color = [UIColor clearColor];
}


+ (UIView *)getShowViewWithView:(UIView *)view
{
//    if (view == nil){
//        //SDK8.0后 防止UITextEffectsWindow显示而获取不到真正window的问题
//        for (int i = (int)[UIApplication sharedApplication].windows.count  - 1 ; i >= 0 ; i --) {
//            view =  [UIApplication sharedApplication].windows[i];
//            if([view isMemberOfClass:[UIWindow class]]){
//                break;
//            }
//        }
//    };
    UIViewController *vc = [MBProgressHUD getCurrentVC];
    return vc.view;
}




@end
