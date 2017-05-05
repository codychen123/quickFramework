/*!
 @header      UMSocialTool.m
 @abstract    友盟分享工具类
 @author      Created by 汪特龙 on 16/8/15
 @version     16/8/15
 Copyright © 2016年 peb. All rights reserved.
 */


#import "UMSocialTool.h"
#import <UShareUI/UShareUI.h>
//微信Appid
#define kWechatAppId @"wx59c46d496c9e7109"
//微信AppSecret
#define kWechatAppSecret @"f20fae7b13d21a6d481fecc7c82968a0"
//微信跳转URL
#define kWechatURL @"http://bing.cn"

//QQ Appid
#define kQQAppId @"1105628485"
//QQ AppKey
#define kQQAppKey @"VKsVDv3f2fUpi66X"
//QQ URL
#define kQQURL @"http://bing.cn"

//微博AppKey
#define kSinaAppKey @"4033907289"
#define kSinaAppHost @"b3b8b4604a2ccd3bde62e98c5594993f"
//微博AppSecret
#define kSinaAppSecret @"b3b8b4604a2ccd3bde62e98c5594993f"
//微博URL
#define kSinaURL @"http://bing.cn"

@implementation UMSocialTool




+ (void)setupUMSocial
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWechatAppId appSecret:kWechatAppSecret redirectURL:kWechatURL];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQAppId/*设置QQ平台的appID*/  appSecret:kQQAppKey redirectURL:kQQURL];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaAppKey  appSecret:kSinaAppSecret redirectURL:kSinaURL];
}


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
               failure:(void (^)(NSString *returnMessage,NSError *error))failure

{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = @"社会化组件";
        messageObject.title = @"123";
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            NSString *message = nil;
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
                message = [NSString stringWithFormat:@"分享成功"];
                success(message);
            }else{
                NSLog(@"response data is %@",data);
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                failure(message,error);
            }
        }];
    }];
}

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"PEB APP，所有人的自由空间，无限制，享生活" descr:@"节省时间和金钱，致力于更好的金融服务" thumImage:[UIImage imageNamed:@"Icon-60"]];
    //设置网页地址
    NSString *url = [[kUseNetWorkNormalURL stringByAppendingString:@"/public/reg.html?invitationCode="]stringByAppendingString:userInfos.code];
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [MBProgressHUD showOnlyMessage:@"分享失败"];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}
@end
