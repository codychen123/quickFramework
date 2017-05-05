/*!
 @header      MainTabBarController.m
 @abstract    主选项控制器
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */


#import "MainTabBarController.h"
#import "NewHomeViewController.h"
#import "BaseWebViewController.h"
#import "NewPEBViewController.h"
#import "CommunityViewController.h"
#import "MineTableViewController.h"
#import "NewAgainPEBViewController.h"
#import "NewAgainAndAgainPEBViewController.h"
#import "CheckAppVersionTool.h"

@interface MainTabBarController()<UINavigationControllerDelegate , UITabBarControllerDelegate>

@end
@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self setDelegate:self];
    
}


- (void)setupUI
{
    //首页
    NewHomeViewController *homeVC = [[NewHomeViewController alloc] init];
    UINavigationController *nav_home = [[UINavigationController alloc]initWithRootViewController:homeVC];
    nav_home.delegate = self;

    //普银
    NewAgainAndAgainPEBViewController *pebVC = [NewAgainAndAgainPEBViewController storyboardName:@"PEB" className:@"NewAgainAndAgainPEBViewController"];
    UINavigationController *nav_peb = [[UINavigationController alloc] initWithRootViewController:pebVC];
    nav_peb.delegate = self;

    
    //社区
    CommunityViewController *communityVC = [[CommunityViewController alloc] init];
    UINavigationController *nav_community = [[UINavigationController alloc] initWithRootViewController:communityVC];
    nav_community.delegate = self;
    
    
    //我的
    MineTableViewController *mineVc = [[MineTableViewController alloc] init];
    UINavigationController *nav_mine = [[UINavigationController alloc] initWithRootViewController:mineVc];
    nav_mine.delegate = self;
    // 屏蔽
    if ([CheckAppVersionTool sharedInstance].isShow) {
        self.viewControllers = [NSArray arrayWithObjects:nav_home,nav_peb,nav_community,nav_mine, nil];
        [self setupItemWithTitle:@"首页" image:@"in_ricon0" selectImage:@"in_hicon0" index:0];
        [self setupItemWithTitle:@"普银" image:@"in_ricon1" selectImage:@"in_hicon1" index:1];
        [self setupItemWithTitle:@"社区" image:@"in_ricon2" selectImage:@"in_hicon2" index:2];
        [self setupItemWithTitle:@"我的" image:@"in_ricon3" selectImage:@"in_hicon3" index:3];
    }else{
        self.viewControllers = [NSArray arrayWithObjects:nav_home,nav_community,nav_mine, nil];
        [self setupItemWithTitle:@"首页" image:@"in_ricon0" selectImage:@"in_hicon0" index:0];
        [self setupItemWithTitle:@"社区" image:@"in_ricon2" selectImage:@"in_hicon2" index:1];
        [self setupItemWithTitle:@"我的" image:@"in_ricon3" selectImage:@"in_hicon3" index:2];
    }
    
    //自定义底部颜色
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 1)];
    bgView.backgroundColor = RGBA(220, 220, 220, 0);
    [self.tabBar insertSubview:bgView atIndex:0];    
}



/**
 *  设置成员
 *
 *  @param title       标题
 *  @param image       图片
 *  @param selectImage 选中图片
 *  @param index       下标
 *
 *  @return 返回UITabBarItem
 */
- (UITabBarItem *)setupItemWithTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage index:(int)index
{
    UITabBarItem *item = [self.tabBar.items objectAtIndex:index];
    [item setTitle:title];
    [item setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
    titleDict[NSForegroundColorAttributeName] = NAV_GRAY_COLOR;
    [item setTitleTextAttributes:titleDict forState:UIControlStateNormal];
    
    NSMutableDictionary *titleDictSelect = [NSMutableDictionary dictionary];
    titleDictSelect[NSForegroundColorAttributeName] = MAIN_RED_COLOR;
    [item setTitleTextAttributes:titleDictSelect forState:UIControlStateSelected];
    item.tag = index;
    return item;
}


/**
 *  选中TabBar
 *
 *  @param tabBarController TabBar控制器
 *  @param viewController   视图控制器
 */
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    if (tabBarController.selectedIndex == 2) {
//        if ([GlobalDataModel sharedInstance].isCompleteLogin == NO) {
//            LoginViewController * loginCtl = [[LoginViewController alloc] init];;
//            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginCtl];
//            [self presentViewController:nav animated:YES completion:nil];
//            tabBarController.selectedViewController = tabBarController.viewControllers[0];
            
//        }
//    }
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if ([viewController isKindOfClass:[MineViewController class]]||[viewController isKindOfClass:[RightsAndInterestsViewController class]]||[viewController isKindOfClass:[ZSMemberMoreViewController class]]) {
//        [navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:ORANGE_COLOR] forBarMetrics:UIBarMetricsDefault];
//        [navigationController.navigationBar setBackgroundColor:ORANGE_COLOR];
//        [navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//        [navigationController.navigationBar setTintColor:ORANGE_COLOR];
//        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:DEFAULTFONT size:17.0f]}];
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        
//    }else{
//        [navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//        [navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//        [navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//        [navigationController.navigationBar setTintColor:NAV_TINT_COLOR];
//        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:NAV_TEXT_COLOR, NSFontAttributeName:[UIFont fontWithName:DEFAULTFONT size:17.0f]}];
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    }
}

@end
