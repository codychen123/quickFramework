/*!
 @header      EditPageHeaderView.m
 @abstract    分页Menu头部视图
 @author      Created by 汪特龙 on 16/10/22
 @version     16/10/22
   Copyright © 2016年 peb. All rights reserved.
*/


#import "EditPageHeaderView.h"

@implementation EditPageHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"EditPageHeaderView" owner:self options:nil] firstObject];
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.segment addTarget:self action:@selector(segmentOnValueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentOnValueChange:(UISegmentedControl *)segment
{
    if ([self.delegate respondsToSelector:@selector(segmentValueChanged:)]) {
        [self.delegate segmentValueChanged:self.segment];
    }
}


@end
