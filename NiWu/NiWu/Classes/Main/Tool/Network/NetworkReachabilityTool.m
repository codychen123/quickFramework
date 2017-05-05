/*!
 @header      NetworkReachabilityTool.m
 @abstract    网络连接状态工具类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */


#import "NetworkReachabilityTool.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation NetworkReachabilityTool


- (BOOL)isReachable
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

- (BOOL)isReachableViaWiFi
{
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

-(BOOL)isReachableViaWWAN
{
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN];
}

- (NetworkReachabilityStatus)networkReachabilityStatus
{
    int enumType = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    return enumType;
}


+ (NetworkReachabilityStatus)getNetWorkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //启动网络监听
    [manager startMonitoring];
    
    __block NetworkReachabilityStatus reachabilityStatus = NetworkReachabilityStatusUnknown;
    //如果网络状态改变,则进行日志输出
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                PYLogInfo(@"未知网络");
                [MBProgressHUD showOnlyMessage:@"当前网络已断开,请重新连接网络"];
                reachabilityStatus = NetworkReachabilityStatusUnknown;
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                PYLogInfo(@"无网络或网络不可用");
                [MBProgressHUD showOnlyMessage:@"当前网络不可用,请重新连接网络"];
                reachabilityStatus = NetworkReachabilityStatusNotReachable;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                PYLogInfo(@"可用2/3/4G网络");
                [MBProgressHUD showOnlyMessage:@"当前连接的是2/3/4G网络"];
                reachabilityStatus = NetworkReachabilityStatusReachableViaWWAN;
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                PYLogInfo(@"可用WIFI网络");
                reachabilityStatus = NetworkReachabilityStatusReachableViaWiFi;
                break;
            }
        }
    }];
    
    return reachabilityStatus;
}


/**
 *  获取本地IP地址
 *
 *  @return IP地址
 */
+ (NSString *)getIpAddresses
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}


/**
 *  获取设备外网IP
 *
 *  @return 字典
 */
+ (NSDictionary *)deviceWANIPAdress
{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return dict;
    }
    return nil;
}


@end
