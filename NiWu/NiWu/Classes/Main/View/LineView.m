/*!
 @header      LineView.m
 @abstract    source code
 @author      Created by PEB on 2017/3/7
 @version     2017/3/7
   Copyright © 2017年 peb. All rights reserved.
*/


#import "LineView.h"

@implementation LineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1.0 / [UIScreen mainScreen].scale);
}

@end
