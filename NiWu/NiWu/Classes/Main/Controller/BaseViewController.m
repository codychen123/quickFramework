/*!
 @header      BaseViewController.m
 @abstract    ViewController基类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "ErrorView.h"

#define kSuspensionTopMargin 10
#define kLeftRightItemW 30

@interface BaseViewController () 
@property (strong, nonatomic) ErrorView * errorView;
@end
@implementation BaseViewController



- (UIButton *)suspensionTopButton
{
    if (_suspensionTopButton == nil) {
        CGFloat btnW = 44;
        _suspensionTopButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW - kSuspensionTopMargin, SCREEN_HEIGHT - btnW - kSuspensionTopMargin, btnW, btnW)];
        [_suspensionTopButton setImage:[UIImage imageNamed:@"back_top"] forState:UIControlStateNormal];
        [[UIApplication sharedApplication].keyWindow addSubview:_suspensionTopButton];
    }
    return _suspensionTopButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseUI];
    [self setupBaseData];
}

- (void)setupBaseUI {
    
}

- (void)setupBaseData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self hideSuspensionTopBtn];
    [super viewWillDisappear:animated];
}



/**
 *  显示悬浮置顶按钮
 *
 *  @param hasTabBar 是否存在TabBar
 *  @param alpha     透明度
 *  @param action    点击后调用的方法
 */
- (void)showSuspensionTopBtn:(BOOL)hasTabBar transparent:(CGFloat)alpha action:(SEL)action
{
    self.suspensionTopButton.hidden = NO;
    if (hasTabBar) {
        self.suspensionTopButton.y = SCREEN_HEIGHT - 49 - self.suspensionTopButton.height - kSuspensionTopMargin;
    }else{
        self.suspensionTopButton.y = SCREEN_HEIGHT  - self.suspensionTopButton.height - kSuspensionTopMargin;
    }
    
    self.suspensionTopButton.alpha = alpha;
    [self.suspensionTopButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  设置悬浮置顶按钮透明度
 *
 *  @param alpha 透明度
 */
- (void)setupSuspensionTopBtnTransparent:(CGFloat)alpha
{
    self.suspensionTopButton.alpha = alpha;
}


/**
 *  隐藏悬浮置顶按钮
 */
- (void)hideSuspensionTopBtn
{
    self.suspensionTopButton.hidden = YES;
}

#pragma mark - ErrorView

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo
{
    if (self.errorView == nil) {
        self.errorView = [[[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil] objectAtIndex:0];
        [self.errorView setFrame:self.view.bounds];
        [self.view addSubview:self.errorView];
    }
    self.errorView.type = type;
    self.errorView.hidden = NO;
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:todo];
    [self.errorView addGestureRecognizer:tapRec];
}

- (void)showErrorViewWithType:(ErrorType)type addToView:(UIView *)bgView todo:(SEL)todo
{
    if (self.errorView == nil) {
        self.errorView = [[[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil] objectAtIndex:0];
        [self.errorView setFrame:self.view.bounds];
        [bgView addSubview:self.errorView];
    }
    self.errorView.type = type;
    self.errorView.hidden = NO;
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:todo];
    [self.errorView addGestureRecognizer:tapRec];
}

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo isMarginToTop :(BOOL)isMargin
{
    if (self.errorView == nil) {
        self.errorView = [[[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil] objectAtIndex:0];
        if (isMargin == YES) {
             [self.errorView setFrame:CGRectMake(0, 53, SCREEN_WIDTH,SCREEN_HEIGHT-53)];
             [self.view addSubview:self.errorView];
        }
        
    }
    self.errorView.type = type;
    self.errorView.hidden = NO;
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:todo];
    [self.errorView addGestureRecognizer:tapRec];
}

- (void)hideErrorView
{
    self.errorView.hidden = YES;
}

- (void)errorMessageShowViewWithString :(NSString *)message andBlock:(MMPopupItemHandler)block andItemTitles:(NSArray *)titles andItemCout:(NSInteger)count
{
    
    [MMAlertViewConfig globalConfig].itemHighlightColor = ORANGE_COLOR;
    [MMAlertViewConfig globalConfig].itemNormalColor = RGBA(47, 47, 47, 1);
    [MMAlertViewConfig globalConfig].titleFontSize = 17;
    [MMAlertViewConfig globalConfig].buttonHeight = 60;
  
    NSArray *items ;
    if (count == 2) {
        MMPopupItem *confirmItem = MMItemMake([titles firstObject], MMItemTypeHighlight, nil);
        MMPopupItem *cancelItem = MMItemMake([titles lastObject], MMItemTypeNormal, block);
        items = @[cancelItem,confirmItem];
    }else{
        MMPopupItem *confirmItem = MMItemMake([titles firstObject], MMItemTypeHighlight, nil);
        items = @[confirmItem];
    }
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:message detail:nil items:items];
    [alertView showWithBlock:nil];
}

@end
