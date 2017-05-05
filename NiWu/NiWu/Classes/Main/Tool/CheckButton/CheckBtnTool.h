/*!
 @header      CheckBtnTool.h
 @abstract    发送验证码工具类
 @author      Created by 汪特龙 on 16/7/1
 @version     16/7/1
   Copyright © 2016年 Lun. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface CheckBtnTool : NSObject
@property (nonatomic , strong) NSTimer *timer;

+ (instancetype)shareInstance;

//进行计时, 并且等待计时中按钮灰选
- (void)startTimerWithButton:(UIButton *)button;
- (void)timerStart;
- (void)resetTimer;
@end
