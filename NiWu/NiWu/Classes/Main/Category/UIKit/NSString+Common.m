//
//  NSString+Common.m
//  HJShop
//
//  Created by 一大口内涵 on 16/9/28.
//  Copyright © 2016年 peb. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)
//判断是否为整形
-(BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
-(BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//判断是否是手机号码
- (BOOL)isPhoneNo{
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//判断是否是邮箱
- (BOOL)isEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//判断是否是传真
-(BOOL)isFax{
    NSString *faxRegex=@"^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$";
    NSPredicate *faxTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", faxRegex];
    return [faxTest evaluateWithObject:self];
    
    
}

//身份证号
+(BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//剔除空字符串
+(NSString *)deleteWhitespaceString:(NSString *)string{
    
    return  [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}
// 判断字符串是否为空字符的方法，空对象

+ (BOOL)isBlankString:(NSString *)str{
    if (str == nil || self == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
/// 拼图片url
//- (NSString *)imageUrlStr{
//    return [kUseNetWorkAssetsRootUrl stringByAppendingString:self];
//}

@end
