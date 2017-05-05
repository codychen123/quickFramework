//
// Created by Hee on 06/03/2017.
// Copyright (c) 2017 peb. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Alert : NSObject

+ (void)alertTitle:(NSString *)title  message:(NSString *)msg okBtnTouch:(CommonBlockVoid)block;

+ (void)alertTitle:(NSString *)title  message:(NSString *)msg isNeedCancel:(BOOL)isNeedCancel okBtnTouch:(CommonBlockVoid)block;
@end
