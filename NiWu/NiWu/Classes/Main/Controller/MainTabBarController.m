/*!
 @header      MainTabBarController.m
 @abstract    主选项控制器
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */


#import "MainTabBarController.h"
#import "CheckAppVersionTool.h"
#import "MineViewController.h"
#import "DiscoverViewController.h"
#import "ShopViewController.h"
#import "MessageViewController.h"

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
    //发现
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] init];
    UINavigationController *nav_home = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    nav_home.delegate = self;

    //购物
    ShopViewController *shopVC = [[ShopViewController alloc] init];
    UINavigationController *nav_peb = [[UINavigationController alloc] initWithRootViewController:shopVC];
    nav_peb.delegate = self;

    
    //消息
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    UINavigationController *nav_community = [[UINavigationController alloc] initWithRootViewController:messageVC];
    nav_community.delegate = self;
    
    
    //我的
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *nav_mine = [[UINavigationController alloc] initWithRootViewController:mineVC];
    nav_mine.delegate = self;
    // 屏蔽
        self.viewControllers = [NSArray arrayWithObjects:nav_home,nav_peb,nav_community,nav_mine, nil];
        [self setupItemWithTitle:@"发现" image:@"in_ricon0" selectImage:@"in_hicon0" index:0];
        [self setupItemWithTitle:@"购物" image:@"in_ricon1" selectImage:@"in_hicon1" index:1];
        [self setupItemWithTitle:@"消息" image:@"in_ricon2" selectImage:@"in_hicon2" index:2];
        [self setupItemWithTitle:@"我的" image:@"in_ricon3" selectImage:@"in_hicon3" index:3];
    
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

@end
