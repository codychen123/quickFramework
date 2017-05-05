/*!
 @header      ProJectInfoTool.m
 @abstract    项目信息工具类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */


#import "ProjectInfoTool.h"

@implementation ProjectInfoTool
/**
 *  获取项目名称
 *
 *  @return 字符串
 */
+(NSString *)getProjectName
{
     return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}
/**
 *  获取项目大版本号Version
 *
 *  @return 字符串
 */
+(NSString *)getProjectVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
/**
 *  获取项目小版本号Build
 *
 *  @return 字符串
 */
+(NSString *)getProjectBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
/**
 *  获取项目包名
 *
 *  @return 字符串
 */
+(NSString *)getProjectIdentifier
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
/**
 *  获取项目路径
 *
 *  @return 字符串
 */
+(NSString *)getProjectPath
{
    return [[NSBundle mainBundle] resourcePath];
}
@end
