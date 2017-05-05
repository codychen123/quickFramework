/*!
 @header      BaseViewController.h
 @abstract    ViewController基类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "ErrorView.h"
#import <MMAlertView.h>

@interface BaseViewController : UIViewController

@property (nonatomic , strong) UIButton *suspensionTopButton;

//显示悬浮置顶按钮
- (void)showSuspensionTopBtn:(BOOL)hasTabBar transparent:(CGFloat)alpha action:(SEL)action;
- (void)setupSuspensionTopBtnTransparent:(CGFloat)alpha;
//隐藏悬浮置顶按钮
- (void)hideSuspensionTopBtn;

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo;

- (void)showErrorViewWithType:(ErrorType)type addToView:(UIView *)bgView todo:(SEL)todo;

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo isMarginToTop :(BOOL)isMargin;

- (void)hideErrorView;
//自定义错误信息提示视图
- (void)errorMessageShowViewWithString :(NSString *)message andBlock:(MMPopupItemHandler)block andItemTitles:(NSArray *)titles andItemCout:(NSInteger)count;

- (void)setupBaseUI;
- (void)setupBaseData;

@end
