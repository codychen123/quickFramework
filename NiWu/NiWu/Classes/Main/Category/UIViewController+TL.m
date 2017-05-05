//
//  UIViewController+TL.m
//  HJShop
//
//  Created by aTeLong on 16/11/5.
//  Copyright © 2016年 peb. All rights reserved.
//

#import "UIViewController+TL.h"
#import "UIImage+YYAdd.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"

@implementation UIViewController (TL)


+ (__kindof UIViewController *)storyboardName:(NSString *)sbName className:(NSString *)className
{
    id  vc = [[UIStoryboard storyboardWithName:sbName bundle:nil]instantiateViewControllerWithIdentifier:className];
    return vc;
}


- (void)setLeftNavBarButtonWithTitle:(NSString *)title
{
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    [leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAV_GRAY_COLOR, NSFontAttributeName:[UIFont fontWithName:DEFAULTFONT size:15.0f]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)setLeftNavBarButtonWithImage:(NSString *)imageName
{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, kLeftRightItemW, kLeftRightItemW)];
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)setLeftNavBarButtonWithImages:(NSArray *)imageNames actionNames:(NSArray *)actionNames
{
    if (imageNames.count != actionNames.count) {
        PYLog(@"%@" , @"setLeftNavBarButtonWithImages 和 actionNames个数不一致");
    }
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0 ; i < imageNames.count; i++) {
        NSString *imageName = imageNames[i];
        NSString *actionName = actionNames[i];
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setFrame:CGRectMake(0, 0, kLeftRightItemW, kLeftRightItemW)];
        [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [leftButton addTarget:self action:NSSelectorFromString(actionName) forControlEvents:UIControlEventTouchUpInside];
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        [items addObject:leftBarButtonItem];
    }
    self.navigationItem.leftBarButtonItems = items ;
}

- (void)setRightNavBarButtonWithTitle:(NSString *)title
{
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    [rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAV_TEXT_COLOR, NSFontAttributeName:[UIFont fontWithName:DEFAULTFONT size:15.0f]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setRightNavBarButtonWithImage:(NSString *)imageName
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, kLeftRightItemW, kLeftRightItemW)];
    [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setRightNavBarButtonWithImages:(NSArray *)imageNames actionNames:(NSArray *)actionNames
{
    if (imageNames.count != actionNames.count) {
        PYLog(@"%@" , @"setLeftNavBarButtonWithImages 和 actionNames个数不一致");
    }
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0 ; i < imageNames.count; i++) {
        NSString *imageName = imageNames[i];
        NSString *actionName = actionNames[i];
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setFrame:CGRectMake(0, 0, kLeftRightItemW, kLeftRightItemW)];
        [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [rightButton addTarget:self action:NSSelectorFromString(actionName) forControlEvents:UIControlEventTouchUpInside];
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        [items addObject:rightBarButtonItem];
    }
    self.navigationItem.rightBarButtonItems = items ;
}


- (void)leftButtonClick
{
    [self goBack];
}

- (void)rightButtonClick
{
     [self toLogin];
}

- (void)goBack
{
    NSArray * viewcontrollers = self.navigationController.viewControllers;
    if (self.navigationController.viewControllers.count > 1) {
        if (self == [viewcontrollers objectAtIndex:viewcontrollers.count - 1]) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        if (self.navigationController == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)toLogin
{
//    if (![GlobalDataModel sharedInstance].isCompleteLogin) {
//        
//        LoginViewController * loginCtl = [[LoginViewController alloc] init];;
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginCtl];
//        [self presentViewController:nav animated:YES completion:nil];
//        
//    }else{
//        
//        NotificationCenterViewController *notificationCenterVC = [[NotificationCenterViewController alloc] init];
//        [self.navigationController pushViewController:notificationCenterVC animated:YES];
//    }
    

}

- (void)goBackToRootView:(BOOL)isPersent
{
    NSArray * viewcontrollers = self.navigationController.viewControllers;
    if (isPersent == NO) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        UIViewController *presentVC = self.presentingViewController;
        if ([presentVC isMemberOfClass:[MainTabBarController class]]) {
            ((MainTabBarController *)presentVC).selectedIndex = 0;
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setEndEditingTap
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)myTap
{
    [self.view endEditing:YES];
}



#pragma mark - MBProgressHUD
- (void)showLoadingViewOnWindow:(NSString *)message
{
    [MBProgressHUD showLoadingViewOnWindow:message toView:nil];
}

- (void)showLoadingViewOnView:(NSString *)message toView:(UIView *)view
{
    [MBProgressHUD showLoadingViewOnWindow:message toView:view];
}

- (void)showLoadingViewOnDim:(NSString *)message
{
    [MBProgressHUD showLoadingViewHaveDim:message toView:nil];
}

- (void)hideLoadingView
{
    [MBProgressHUD hideHUD];
}

- (void)showSuccessView:(NSString *)message
{
    [MBProgressHUD showSuccessView:message toView:nil];
}

- (void)showSuccessView:(NSString *)message todo:(SEL)todo
{
    [self showSuccessView:message];
    if (todo != nil) {
        [self performSelector:todo withObject:nil afterDelay:2.0];
    }
}

- (void)showFailureView:(NSString*)message
{
    [MBProgressHUD showFailureView:message toView:nil];
}

- (void)showFailureView:(NSString *)message todo:(SEL)todo
{
    [self showFailureView:message];
    [self performSelector:todo withObject:nil afterDelay:2.0];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

- (void)setNavBarTransparent:(BOOL)isTransparent
{
    if (isTransparent)
    {
        self.navigationController.navigationBar.translucent = YES;
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        CGColorRef color = [[UIColor clearColor] CGColor];
        UIGraphicsBeginImageContext(rect.size);
        //获取当前上下文
        CGContextRef  ref = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ref, color);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.clipsToBounds = YES;
    }else
    {
        self.navigationController.navigationBar.translucent = NO;
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        CGColorRef color = [[UIColor whiteColor] CGColor];
        UIGraphicsBeginImageContext(rect.size);
        //获取当前上下文
        CGContextRef  ref = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ref, color);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.clipsToBounds = NO;
    }
}

//设置导航栏
- (void)setupNavBarColorToBlack
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGBA(32, 35, 37, 1)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:RGBA(32, 35, 37, 1)];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    [self.navigationController.navigationBar setTintColor:RGBA(32, 35, 37, 1)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:DEFAULTFONT size:17.0f]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)setupNavBarColorToDefult
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    [self.navigationController.navigationBar setTintColor:NAV_TINT_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:NAV_TEXT_COLOR, NSFontAttributeName:[UIFont fontWithName:DEFAULTFONT size:17.0f]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setupNavBarColorToOrange
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:ORANGE_COLOR] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:ORANGE_COLOR];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    [self.navigationController.navigationBar setTintColor:ORANGE_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:DEFAULTFONT size:17.0f]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void) hideNavigationBar
{
//    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.fd_prefersNavigationBarHidden = YES;
}


- (void) showNavigationBar:(BOOL)isDuration{
//    if (isDuration == YES) {
//        [UIView animateWithDuration:1.0 animations:^{
//            [self.navigationController.navigationBar setTranslucent:NO];
//            [self.navigationController.navigationBar setShadowImage:nil];
//        }];
//    }else{
//        [self.navigationController.navigationBar setTranslucent:NO];
//        [self.navigationController.navigationBar setShadowImage:nil];
//    }

}


- (BOOL)isNeedLogin {
    BOOL isCompleteLogin = [[GlobalDataModel sharedInstance] isCompleteLogin];
    if (isCompleteLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [KEY_WINDOW.rootViewController presentViewController:nav animated:YES completion:nil];
        return YES;
    }
    else {
        return NO;
    }
}





@end
