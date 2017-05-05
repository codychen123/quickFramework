//
//  CheckAppVersionTool.h
//  PEB
//
//  Created by hxt_025 on 2017/3/24.
//  Copyright © 2017年 peb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckAppVersionTool : NSObject

/** 是否显示 */
@property (assign, nonatomic) BOOL isShow;

/** 升级链接 */
@property (nonatomic,copy) NSString *updateUrl;


/**
 判断服务器上的版本与当前的版本

 @param currentVersion 服务器上的版本    只有当前版本小于或者等于服务器里的版本的时候,界面正常显示,否则隐藏
 @param showVersion 显示的版本号
 @param newVersionUrl  升级链接
 @param message 描述信息
 @return 是否隐藏
 */
- (BOOL)checkAppVessionIsEqualToCurrentVersion:(NSString *)currentVersion showVersion:(NSString *)showVersion urlToAppStore:(NSString *)newVersionUrl  message:(NSString *)message;

+ (CheckAppVersionTool *)sharedInstance;

@end
