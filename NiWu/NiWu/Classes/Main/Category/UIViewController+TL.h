//
//  UIViewController+TL.h
//  HJShop
//
//  Created by aTeLong on 16/11/5.
//  Copyright © 2016年 peb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorView.h"
#define kSuspensionTopMargin 10
#define kLeftRightItemW 30

@interface UIViewController (TL)



- (void)setNavBarTransparent:(BOOL)isTransparent;
- (void)setLeftNavBarButtonWithTitle:(NSString *)title;
- (void)setLeftNavBarButtonWithImage:(NSString *)imageName;
- (void)setRightNavBarButtonWithTitle:(NSString *)title;
- (void)setRightNavBarButtonWithImage:(NSString *)imageName;

- (void)setLeftNavBarButtonWithImages:(NSArray *)imageNames actionNames:(NSArray *)actionNames;
- (void)setRightNavBarButtonWithImages:(NSArray *)imageNames actionNames:(NSArray *)actionNames;

- (void)leftButtonClick;
- (void)rightButtonClick;
- (void)goBack;
- (void)goBackToRootView:(BOOL)isPersent;
- (void)setEndEditingTap;
- (void)toLogin;
#pragma mark - MBProgressHUD
- (void)showLoadingViewOnWindow:(NSString *)message;
- (void)showLoadingViewOnView:(NSString *)message toView:(UIView *)view;
- (void)showLoadingViewOnDim:(NSString *)message;

- (void)hideLoadingView;

- (void)showSuccessView:(NSString *)message;
- (void)showSuccessView:(NSString *)message todo:(SEL)todo;

- (void)showFailureView:(NSString *)message;
- (void)showFailureView:(NSString *)message todo:(SEL)todo;

- (void)setupNavBarColorToBlack;
- (void)setupNavBarColorToDefult;
- (void)setupNavBarColorToOrange;

- (void) hideNavigationBar;
- (void) showNavigationBar:(BOOL)isDuration;

+ (__kindof UIViewController *)storyboardName:(NSString *)sbName className:(NSString *)className;

- (BOOL)isNeedLogin ;
@end
