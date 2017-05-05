//
//  MineViewController.m
//  NiWu
//
//  Created by xiaohuihui on 2017/5/5.
//  Copyright © 2017年 MeiZhiBangCompany. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (instancetype)init
{
    if (self == [super init]) {
        self = [MineViewController storyboardName:@"Mine" className:@"MineViewController"];
    }
    return self;
}

- (void)setupBaseUI {
    [self hideNavigationBar];
}

@end
