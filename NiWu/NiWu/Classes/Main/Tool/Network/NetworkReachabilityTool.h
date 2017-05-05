/*!
 @header      NetworkReachabilityTool.h
 @abstract    网络连接状态工具类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSInteger,NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,
    NetworkReachabilityStatusNotReachable     = 0,
    NetworkReachabilityStatusReachableViaWWAN = 1,
    NetworkReachabilityStatusReachableViaWiFi = 2,
};

@interface NetworkReachabilityTool : NSObject
/**
 *  当前网络状态
 */
@property (readonly, nonatomic, assign) NetworkReachabilityStatus networkReachabilityStatus;
/**
 *  当前网络是否可用
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;
/**
 *  当前网络是否2/3/4G
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;
/**
 *  当前网络是否WIFI
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

/**
 *  获取网络状态
 *
 *  @return 状态枚举
 */
+(NetworkReachabilityStatus)getNetWorkStatus;

/**
 *  获取本地IP地址
 *
 *  @return IP地址
 */
+ (NSString *)getIpAddresses;


/**
 *  获取设备外网IP
 *
 *  @return 字典  (cip 字段为IP地址)
 */
+ (NSDictionary *)deviceWANIPAdress;

@end
