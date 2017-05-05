/*!
 @header      CheckBtnTool.m
 @abstract    发送验证码工具类
 @author      Created by 汪特龙 on 16/7/1
 @version     16/7/1
   Copyright © 2016年 Lun. All rights reserved.
*/


#import "CheckBtnTool.h"

#define kTimerSecond 90

@interface CheckBtnTool()
@property (nonatomic , strong) UIButton *btn;
@property (nonatomic , strong) UIColor *backgroundColor;
@property (nonatomic , strong) UIColor *fontColor;
@end
@implementation CheckBtnTool

static int timerSecond = kTimerSecond;
static CheckBtnTool *_instance;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CheckBtnTool alloc] init];
    });
    return _instance;
}


//进行计时, 并且等待计时中按钮灰选
- (void)startTimerWithButton:(UIButton *)button
{
    self.btn = button;
    self.btn.enabled = NO;
    self.btn.selected = YES;
    self.backgroundColor = self.btn.backgroundColor;
    self.fontColor = self.btn.titleLabel.textColor;
    [self.btn setBackgroundColor:[UIColor lightGrayColor]];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
        [self.timer fire];
    }
}

- (void)timerStart
{
    if (timerSecond > 0 ) {
        timerSecond -- ;
        NSString *str = [NSString stringWithFormat:@"%i秒重发", timerSecond];
        [self.btn setTitle:str forState:UIControlStateNormal];
        [self.btn setTitle:str forState:UIControlStateSelected];
        [self.btn setTitle:str forState:UIControlStateHighlighted];
    }else
    {
        timerSecond = kTimerSecond;
        self.btn.enabled = YES;
        self.btn.selected = YES;
        [self.btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.btn setTitle:@"获取验证码" forState:UIControlStateSelected];
        [self.btn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
        
        [self.btn setTitleColor:self.fontColor forState:UIControlStateNormal];
        [self.btn setTitleColor:self.fontColor forState:UIControlStateSelected];
        [self.btn setTitleColor:self.fontColor forState:UIControlStateHighlighted];
        
        self.btn.backgroundColor = self.backgroundColor;
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)resetTimer{
    timerSecond = kTimerSecond;
    self.btn.enabled = YES;
    self.btn.selected = YES;
    [self.btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.btn setTitle:@"获取验证码" forState:UIControlStateSelected];
    [self.btn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    
    [self.btn setTitleColor:self.fontColor forState:UIControlStateNormal];
    [self.btn setTitleColor:self.fontColor forState:UIControlStateSelected];
    [self.btn setTitleColor:self.fontColor forState:UIControlStateHighlighted];
    
    self.btn.backgroundColor = self.backgroundColor;
    [self.timer invalidate];
    self.timer = nil;
}


@end
