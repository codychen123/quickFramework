/*!
 @header      VerificationTool.m
 @abstract    校验工具类
 @author      Created by 汪特龙 on 16/4/22
 @version     16/4/22
 Copyright © 2016年 peb. All rights reserved.
 */

#import "VerificationTool.h"

@implementation VerificationTool

/**
 *  校验手机号码
 *
 *  @param telNumber 手机号
 *
 *  @return 是否正常
 */
+ (BOOL)checkTelNumber:(NSString *)telNumber
{
    NSString *pattern = @"^1+[345678]+\\d{9}";
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger resultCount = [regular numberOfMatchesInString:telNumber options:NSMatchingReportProgress range:NSMakeRange(0, telNumber.length)];
    return resultCount > 0;
}

/**
 *  校验用户密码(密码设置规则：密码长度6～16位，由英文字母a～z (区分大小写)、数字0～9、特殊字符至少两种组合组成，且不可与帐号相同。)
 *
 *  @param password 密码
 *
 *  @return 是否正常
 */
+ (BOOL)checkPassword:(NSString *)password
{
    NSString *pattern = @"^((?=.*\\d)(?=.*\\D)|(?=.*[a-zA-Z])(?=.*[^a-zA-Z]))^.{6,16}$";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger resultCount = [regular numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    return resultCount > 0;
    return YES;
}


/**
 *  校验交易密码(6数字)
 *
 *  @param password 密码
 *
 *  @return 是否正常
 */
+ (BOOL)checkPayPassword:(NSString *)password
{
    NSString *pattern = @"^[0-9]{6}$";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger resultCount = [regular numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    return resultCount > 0;
}

/**
 *  校验用户名(50位的中文或英文)
 *
 *  @param userName 用户名
 *
 *  @return 是否正常
 */
+ (BOOL)checkUserName:(NSString *)userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA50-9@.]{1,50}$";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger resultCount = [regular numberOfMatchesInString:userName options:NSMatchingReportProgress range:NSMakeRange(0, userName.length)];
    return resultCount > 0;
}


/**
 *  校验身份证
 *
 *  @param idCard 身份证
 *
 *  @return 是否正常
 */
+ (BOOL)checkUserIdCard:(NSString *)idCard
{
    NSString *pattern = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger resultCount = [regular numberOfMatchesInString:idCard options:NSMatchingReportProgress range:NSMakeRange(0, idCard.length)];
    return resultCount > 0;
}


/**
 *  正则匹配URL
 *
 *  @param url 地址
 *
 *  @return 是否正常
 */
+ (BOOL)checkURL:(NSString *)url
{
    NSString *pattern = @"[a-zA-Z]+://[^\\s]*";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger resultCount = [regular numberOfMatchesInString:url options:NSMatchingReportProgress range:NSMakeRange(0, url.length)];
    return resultCount > 0;
}


/**
 *  校验邮箱
 *
 *  @param email 邮箱地址
 *
 *  @return 是否正常
 */
+ (BOOL)checkEmail:(NSString *)email
{
    NSString *pattern = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger resultCount = [regular numberOfMatchesInString:email options:NSMatchingReportProgress range:NSMakeRange(0, email.length)];
    return resultCount > 0;
}

/**
 *  校验键盘自带表情
 *
 *  @param email 邮箱地址
 *
 *  @return 是否正常
 */
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}

@end
