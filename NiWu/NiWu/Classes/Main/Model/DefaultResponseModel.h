/*!
 @header      DefaultResponseModel.h
 @abstract    默认的响应参数
 @author      Created by 汪特龙 on 16/7/19
 @version     16/7/19
   Copyright © 2016年 peb. All rights reserved.
*/

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , ReturnCode) {
    /// 成功
    ReturnCodeSuccess = 0000,
    
    /// 未知错误
    ReturnCodeUnknowError = 1001,
    
    /// 请求参数错误
    ReturnCodeParamExceptionNull= 1002,
    
    /// 参数错误
    ReturnCodeCommonParamInvalid = 1003,
    
    /// 用户token不正确,没有操作权限
    ReturnCodeuserNotPermitted = 1004,
    
    // Sign已失效
    ReturnSignTimeout =  0012,
    
    /// 密码失效
    ReturnCodeCommonUserPassordError = 1101,
    
    /// 验证码失效
    ReturnCodeCommonVerifyCodeTimeout = 1102,
    
    /// 验证错误
    ReturnCodeCommonVerifyCodeInvalid = 1103,
    
    /// 用户名已存在
    ReturnCodeCommonUsernameExist = 1104,
    
    /// 用户名或密码错误
    ReturnCodeCommonUsernameError = 1105,
    
    /// 密码错误
    ReturnCodeCommonPasswordError = 1106,
    
    /// 交易失败
    ReturnCodeTradingOrderFaild = 1200,
    
    /// 用户已存在
    ReturnCodeContactExisted = 1300,
    
    /// 用户已是朋友
    ReturnCodeFriendExisted = 1301,
    
    /// 手机号码错误
    ReturnCodePhoneError = 1302,
    
    /// 邮箱错误
    ReturnCodeMailError = 1303,
};


@interface DefaultResponseModel : NSObject
/** 返回的结果*/
@property (nonatomic , assign) ReturnCode code;
/** 返回消息 */
@property (nonatomic , copy) NSString *message;
/** 返回数据 */
@property (nonatomic , strong)  id data;
/** 返回异常消息*/
@property (nonatomic , copy) NSString *errorMessage;
@end
