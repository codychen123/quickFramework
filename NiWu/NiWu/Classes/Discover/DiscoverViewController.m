//
//  DiscoverViewController.m
//  NiWu
//
//  Created by xiaohuihui on 2017/5/5.
//  Copyright © 2017年 MeiZhiBangCompany. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (instancetype)init
{
    if (self == [super init]) {
        self = [DiscoverViewController storyboardName:@"Discover" className:@"DiscoverViewController"];
    }
    return self;
}

- (void)setupBaseUI {
    [self hideNavigationBar];
}

@end
