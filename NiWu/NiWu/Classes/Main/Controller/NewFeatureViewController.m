/*!
 @header      NewFeatureViewController.m
 @abstract    版本新特性(引导页)控制器
 @author      Created by 汪特龙 on 16/6/2
 @version     16/6/2
   Copyright © 2016年 Lun. All rights reserved.
*/


#import "NewFeatureViewController.h"

#define kNewFeatureCount 3

@interface NewFeatureViewController()<UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) NSMutableArray *imageArr;

@end
@implementation NewFeatureViewController


- (NSMutableArray *)imageArr
{
    if (_imageArr == nil) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [self setupUI];
    }

    return self;
}

- (void)setupUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * kNewFeatureCount, SCREEN_HEIGHT);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    for (int i = 0 ; i < kNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.imageArr addObject:imageView];

        if (i == kNewFeatureCount - 1) {
            imageView.userInteractionEnabled = YES;
            UIButton *jumpBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 0, 150, 50)];
            [jumpBtn addTarget:self action:@selector(goHomePageOnClick) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:jumpBtn];
            
            UIButton *goHomePageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150, SCREEN_WIDTH, 150)];
            [goHomePageBtn addTarget:self action:@selector(goHomePageOnClick) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:goHomePageBtn];
        }
    }
    
    [self.view addSubview:_scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    for (int i = 0 ; i < self.imageArr.count; i++) {
        UIImageView *imageView  =  self.imageArr[i];
        NSString *imageName =  [NSString stringWithFormat:@"qidongye_0%i", i + 1];
//        if ([UIScreen mainScreen].bounds.size.height == 568.0) {
//            imageName = [NSString stringWithFormat:@"new_feature_%i-1", i + 1 ];
//        }
//        if ([UIScreen mainScreen].bounds.size.height == 480.0) {
//            imageName = [NSString stringWithFormat:@"new_feature_%i-480h", i + 1 ];
//        }
        UIImage *image = [UIImage imageNamed:imageName];
        [imageView setImage:image];
        [_scrollView addSubview:imageView];
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断是否为最后一页
    CGFloat lastW = scrollView.contentSize.width - SCREEN_WIDTH;
    if (scrollView.contentOffset.x > lastW) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.backgroundColor = [UIColor whiteColor];
        window.rootViewController = _tabBarVC;
        [window makeKeyAndVisible];
    }
}


- (void)goHomePageOnClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = _tabBarVC;
    [window makeKeyAndVisible];
}
@end
