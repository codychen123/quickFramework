/*!
 @header      VerificationService.m
 @abstract    校验服务类
 @author      Created by 汪特龙 on 16/8/22
 @version     16/8/22
   Copyright © 2016年 peb. All rights reserved.
*/


#import "VerificationService.h"
#import "VerificationTool.h"

#define kTipsInputMoblie @"请输入正确的手机号码! "
#define kTipsInputUserName @"请输入正确的用户名！"
#define kTipsInputPassword @"请输入交易密码!"
#define kTipsInputVerifyPassword @"请输入确认密码！"
#define kTipsInputVerifyNumber @"请输入验证码！"

#define kTipsWrongMoblie @"请输入正确的手机号码！"
#define kTipsWrongUserName @"请填写正确的用户名！"
#define kTipsWrongPassword @"密码长度6～16位，由英文字母a～z (区分大小写)、数字0～9、特殊字符至少两种组合组成。"


#define kTipsDoingLogin @"正在登录..."

#define kTipsSuccessLogin @"登录成功！"
#define kTipsFailureLogin @"登录失败，请重试！"

#define kTipsDiscordPassword @"两次输入的密码不一致！"


#define kTipsNetworkError @"网络不流畅, 请重新尝试!"

@implementation VerificationService
/**
 *  校验手机号码
 *
 *  @param telNumber 手机号
 *
 *  @return 是否正常
 */
+ (BOOL)checkTelNumber:(NSString *)telNumber tip:(BOOL)tipON
{
    if (telNumber == nil || telNumber.length == 0) {
        if (tipON) {
            [MBProgressHUD showOnlyMessage:kTipsInputMoblie];
        }
        return NO;
    }
    
    if (telNumber.length != 11) {
        if (tipON) {
            [MBProgressHUD showOnlyMessage:@"手机号长度不正确!"];
        }
        return NO;
    }
    
    if([VerificationTool checkTelNumber:telNumber] == NO)
    {
        if (tipON) {
            [MBProgressHUD showOnlyMessage:kTipsWrongMoblie];
        }
        return NO;
    }
    
    return YES;
}

+ (BOOL)checkTelNumber:(NSString *)telNumber {
    return [self checkTelNumber:telNumber tip:YES];
}

/**
 *  校验用户密码(6 - 16位数字和字母组合)
 *
 *  @param password 密码
 *
 *  @return 是否正常
 */
+ (BOOL)checkPassword:(NSString *)password
{
    
    if (password == nil || password.length == 0) {
        [MBProgressHUD showOnlyMessage:kTipsInputPassword];
        return NO;
    }
    
    if (password.length < 6 ) {
        [MBProgressHUD showOnlyMessage:@"密码长度不能小于6位!"];
        return NO;
    }
    
    if (password.length > 16) {
        [MBProgressHUD showOnlyMessage:@"密码长度不能大于16位!"];
        return NO;
    }
    
    if([VerificationTool checkPassword:password] == NO)
    {
        [MBProgressHUD showOnlyMessage:kTipsWrongPassword];
        return NO;
    }
    
    return YES;
}


/**
 *  校验交易密码(6位 数字)
 *
 *  @param password 密码
 *
 *  @return 是否正常
 */
+ (BOOL)checkPayPassword:(NSString *)password
{
    
    if (password == nil || password.length == 0) {
        [MBProgressHUD showOnlyMessage:kTipsInputPassword];
        return NO;
    }
    
    if([VerificationTool checkPayPassword:password] == NO)
    {
        [MBProgressHUD showOnlyMessage:@"交易密码为6位数字!"];
        return NO;
    }
    
    return YES;
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
    if([VerificationTool checkUserName:userName] == NO)
    {
        [MBProgressHUD showOnlyMessage:@"用户名格式不正确!"];
        return NO;
    }
    
    return YES;
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
    if (idCard == nil || idCard.length == 0) {
        [MBProgressHUD showOnlyMessage:@"请输入证件号码"];
        return NO;
    }
    
       if([VerificationTool checkUserIdCard:idCard] == NO)
    {
        [MBProgressHUD showOnlyMessage:@"证件格式不正确!"];
        return NO;
    }
    
    return YES;
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
    if([VerificationTool checkURL:url] == NO)
    {
        [MBProgressHUD showOnlyMessage:@"URL不正确!"];
        return NO;
    }
    return YES;
}


/**
 *  校验邮箱
 *
 *  @param email 邮箱地址
 *
 *  @return 是否正常
 */
+ (BOOL)checkEmail:(NSString *)email tip:(BOOL)tipON
{
    if([VerificationTool checkEmail:email] == NO)
    {
        if (tipON) {
            [MBProgressHUD showOnlyMessage:@"邮箱地址不正确!"];
        }
        return NO;
    }
    return YES;
}

+ (BOOL)checkEmail:(NSString *)email
{
    return [self checkEmail:email tip:YES];
}


/**
 *  校验字符串是否为空(为空返回NO)
 *
 *  @param str 字符串
 *
 *  @return 是否为空
 */
+ (BOOL)checkEmpty:(NSString *)str
{
    if(str == nil || str.length <= 0)
    {
        return NO;
    }
    return YES;
}
@end
