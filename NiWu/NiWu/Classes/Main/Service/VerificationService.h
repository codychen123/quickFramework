/*!
 @header      VerificationService.h
 @abstract    校验服务类
 @author      Created by 汪特龙 on 16/8/22
 @version     16/8/22
   Copyright © 2016年 peb. All rights reserved.
*/

#import <Foundation/Foundation.h>
#import "VerificationService.h"

@interface VerificationService : NSObject
/**
 *  校验手机号码
 *
 *  @param telNumber 手机号
 *
 *  @return 是否正常
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber;

/**
 *  校验密码
 *
 *  @param password 密码
 *
 *  @return 是否正常
 */
+ (BOOL)checkPassword:(NSString *) password;

/**
 *  校验交易密码(6位 数字)
 *
 *  @param password 密码
 *
 *  @return 是否正常
 */
+ (BOOL)checkPayPassword:(NSString *)password;

/**
 *  校验用户名
 *
 *  @param userName 用户名
 *
 *  @return 是否正常
 */
+ (BOOL)checkUserName:(NSString *) userName;
+ (BOOL)checkTelNumber:(NSString *)telNumber tip:(BOOL)tipON;

/**
 *  校验身份证
 *
 *  @param idCard 身份证
 *
 *  @return 是否正常
 */
+ (BOOL)checkUserIdCard:(NSString *) idCard;


/**
 *  校验URL地址
 *
 *  @param url 地址
 *
 *  @return 是否正常
 */
+ (BOOL)checkURL:(NSString *) url;


/**
 *  校验邮箱
 *
 *  @param email 邮箱地址
 *
 *  @return 是否正常
 */
+ (BOOL)checkEmail:(NSString *)email;
+ (BOOL)checkEmail:(NSString *)email tip:(BOOL)tipON;

/**
 *  校验字符串是否为空
 *
 *  @param str 字符串
 *
 *  @return 是否为空
 */
+ (BOOL)checkEmpty:(NSString *)str;
@end
