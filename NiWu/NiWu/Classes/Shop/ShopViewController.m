//
//  ShopViewController.m
//  NiWu
//
//  Created by xiaohuihui on 2017/5/5.
//  Copyright © 2017年 MeiZhiBangCompany. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

- (instancetype)init
{
    if (self == [super init]) {
        self = [ShopViewController storyboardName:@"Shop" className:@"ShopViewController"];
    }
    return self;
}

- (void)setupBaseUI {
    self.title = @"你污";
}

@end
