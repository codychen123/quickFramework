//
//  NSString+Common.h
//  HJShop
//
//  Created by 一大口内涵 on 16/9/28.
//  Copyright © 2016年 peb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
/**
 *  判断是否为整形
 */
-(BOOL)isPureInt;

/**
 *  判断是否为浮点形
 */
-(BOOL)isPureFloat;

/**
 *  判断是否是手机号码
 */
-(BOOL)isPhoneNo;

/**
 *  判断是否是邮箱
 */
-(BOOL)isEmail;

/**
 *  判断是否是传真
 */
-(BOOL)isFax;

/**
 *  身份证
 *
 */
+(BOOL)validateIdentityCard: (NSString *)identityCard;

/**
 * 判断字符串是否为空字符的方法，空对象
 */
+(BOOL)isBlankString:(NSString *)str;

/**
 *  剔除空字符串
 */
+(NSString *)deleteWhitespaceString:(NSString *)string;

/// 拼图片url
//- (NSString *)imageUrlStr;

@end
