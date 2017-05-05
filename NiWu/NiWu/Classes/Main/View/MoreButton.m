//
//  MoreButton.m
//  PEB
//
//  Created by hxt_025 on 2017/4/1.
//  Copyright © 2017年 peb. All rights reserved.
//

#import "MoreButton.h"

@implementation MoreButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 3, self.width-20, 30);
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.imageView.frame = CGRectMake(self.width-15, 10, 8, 15);
}

@end
