/*!
 @header      RefreshFooter.m
 @abstract    <#关于源代码的基本描述#>
 @author      Created by <#名称#> on 11/03/2017
 @version     11/03/2017
 Copyright © 2017 peb. All rights reserved.
 */


#import "RefreshFooter.h"

@implementation RefreshFooter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"上拉加载更多数据" forState:MJRefreshStateIdle];
        [self setTitle:@"松开加载" forState:MJRefreshStatePulling];
        [self setTitle:@"正在加载中" forState:MJRefreshStateRefreshing];
    }
    return self;
}

@end
