/*!
 @header      UMSocialTool.h
 @abstract    友盟分享工具类
 @author      Created by 汪特龙 on 16/8/15
 @version     16/8/15
 Copyright © 2016年 peb. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

@interface UMSocialTool : NSObject
/**
 *  设置各个平台的appid，appkey
 */
+ (void)setupUMSocial;


/**
 实现分享关键方法

 @param imageName 图片地址
 @param title 标题
 @param descr 详情
 @param platform 平台
 @param currentViewController 当前视图控制器
 @param success 成功回调
 @param failure 异常回调
 */
+ (void)shareWithImage:(NSString *)imageName
                 title:(NSString *)title
                 descr:(NSString *)descr
              platform:(UMSocialPlatformType)platform
 currentViewController:(UIViewController *)currentViewController
               success:(void (^)(NSString *returnMessage))success
               failure:(void (^)(NSString *returnMessage,NSError *error))failure;

/// 分享
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType;
@end
