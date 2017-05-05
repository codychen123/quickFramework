/*!
 @header      LongButton.m
 @abstract    long button made for storyboard
 @author      Created by Hee on 07/03/2017
 @version     07/03/2017
   Copyright © 2017 peb. All rights reserved.
*/


#import "LongButton.h"
@implementation LongButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self config];
    }
    return self;
}
- (void)config{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = MAIN_COLOR;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
}
@end


@implementation LongButtonWhite

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self config];
    }
    return self;
}
- (void)config{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = MAIN_COLOR.CGColor;
    self.layer.borderWidth = 1;
//    self.backgroundColor = BG_COLOR;
    [self setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
}
@end
