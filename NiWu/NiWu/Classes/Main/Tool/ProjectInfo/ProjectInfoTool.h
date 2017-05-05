/*!
 @header      ProJectInfoTool.h
 @abstract    项目信息工具类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */



#import <Foundation/Foundation.h>

@interface ProjectInfoTool : NSObject
/**
 *  获取项目名称
 *
 *  @return 字符串
 */
+(NSString *)getProjectName;
/**
 *  获取项目大版本号Version
 *
 *  @return 字符串
 */
+(NSString *)getProjectVersion;
/**
 *  获取项目小版本号Build
 *
 *  @return 字符串
 */
+(NSString *)getProjectBuild;
/**
 *  获取项目包名
 *
 *  @return 字符串
 */
+(NSString *)getProjectIdentifier;
/**
 *  获取项目路径
 *
 *  @return 字符串
 */
+(NSString *)getProjectPath;

@end
