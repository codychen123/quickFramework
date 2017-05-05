//
//  MessageViewController.m
//  NiWu
//
//  Created by xiaohuihui on 2017/5/5.
//  Copyright © 2017年 MeiZhiBangCompany. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (instancetype)init
{
    if (self == [super init]) {
        self = [MessageViewController storyboardName:@"Message" className:@"MessageViewController"];
    }
    return self;
}

- (void)setupBaseUI {
    [self hideNavigationBar];
}

@end
