/*!
 @header      LaunchViewTool.m
 @abstract    <#关于源代码的基本描述#>
 @author      Created by <#名称#> on 17/4/2
 @version     17/4/2
   Copyright © 2017年 peb. All rights reserved.
 */

#import "LaunchViewTool.h"
//#import "CheckVersionModel.h"
#import "CheckAppVersionTool.h"

@interface LaunchViewTool()
/** 停留时间*/
@property (nonatomic , assign) NSInteger showDuration;
@property (nonatomic , strong) UIImageView *launchImageView;
@end
@implementation LaunchViewTool

+ (void)launchViewWithDuration:(NSInteger )duration{
    LaunchViewTool *viewTool = [[self alloc] initWithFrame:WINDOW_FRAME];
    viewTool.showDuration = duration;
    //设置LaunchImageView
    [viewTool addSubview:viewTool.launchImageView];
    //添加异步方法移除启动页
//    [viewTool removeLaunchImageView];
    //添加到Window上
    [viewTool addInWindow];
}

- (void)addInWindow{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}


/**
 获取launch启动页
 */
- (UIView *)launchImageView{
    if(_launchImageView == nil){
        _launchImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _launchImageView.image = [self assetsLaunchImage];
    }
    return _launchImageView;
}


/**
 获取Assets里LaunchImage

 @return 图片
 */
- (UIImage *)assetsLaunchImage{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";//横屏 @"Landscape"
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            launchImageName = dict[@"UILaunchImageName"];
            UIImage *image = [UIImage imageNamed:launchImageName];
            return image;
        }
    }
    return nil;
}

- (void)launchRemove{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView animateWithDuration:1.2 animations:^{
        self.transform = CGAffineTransformMakeScale(2.0, 2.0);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
