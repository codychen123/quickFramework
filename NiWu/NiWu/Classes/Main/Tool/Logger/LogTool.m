/*!
 @header      LogTool.m
 @abstract    日志记录工具
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */


#import "LogTool.h"
#import <CocoaLumberjack/DDLog.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDFileLogger.h>
#import <CocoaLumberjack/DDASLLogger.h>
#import "SystemInfo.h"


@interface LogTool()<DDLogFormatter>

@end
@implementation LogTool

/** 日志等级*/
static int ddLogLevel;

+ (void)load
{
#ifdef DEBUG
    fprintf( stderr, "****************************************************************************************\n" );
    fprintf( stderr, "项目名称:%s	    \n",[ProjectInfoTool getProjectName].UTF8String);
    fprintf( stderr, "项目版本:%s    \n",[ProjectInfoTool getProjectVersion].UTF8String);
    fprintf( stderr, "copyright (c) 2017, {peb}                    \n" );
    fprintf( stderr, "    										       \n" );
    
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    
    fprintf( stderr, "手机型号:%s %s	\n", [SystemInfo platformString].UTF8String, [SystemInfo osVersion].UTF8String );
    fprintf( stderr, "IP 地址: %s	\n", [SystemInfo localIPAddress].UTF8String );
    fprintf( stderr, "文件路径: %s	\n", [NSBundle mainBundle].bundlePath.UTF8String );
    fprintf( stderr, "系统时间: %s	\n", [SystemInfo systemTimeInfo].UTF8String);
    fprintf( stderr, "    												\n" );
    fprintf( stderr, "****************************************************************************************\n" );
#endif
    
#endif
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        //DDTTYLogger 将 Log 发送给 Xcode 的控制台
        [[DDTTYLogger sharedInstance] setLogFormatter:self];
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        //DDASLLogger将 Log 发送给苹果服务器，之后在 Console.app 中可以查看
        [[DDASLLogger sharedInstance] setLogFormatter:self];
        [DDLog addLogger:[DDASLLogger sharedInstance]];
        
        //调整颜色
        char *xcode_colors = getenv("XcodeColors");
        if (xcode_colors && (strcmp(xcode_colors, "YES") == 0))
        {
            [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
            [[DDTTYLogger sharedInstance] setForegroundColor:RGBA(0, 251, 154 ,1) backgroundColor:RGBA(0, 0, 0 ,1) forFlag:DDLogFlagInfo];;
            
            [[DDTTYLogger sharedInstance] setForegroundColor:RGBA(0, 117, 250 ,1) backgroundColor:RGBA(0, 0, 0 ,1) forFlag:DDLogFlagDebug];;
            
            [[DDTTYLogger sharedInstance] setForegroundColor:RGBA(255, 0, 0 ,1) backgroundColor:RGBA(0, 0, 0 ,1) forFlag:DDLogFlagError];;
        }
    }
    return self;
}

+ (void)startWithLogLevel:(PYLogLevel)logLevel
{
    [self shareInstance];
    [[self shareInstance] setLogLevel:logLevel];
}

static LogTool *_instance;
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LogTool alloc]init];
    });
    return _instance;
}


/**
 *  设置格式器
 *
 *  @param logMessage 封装日志消息的信息类
 *
 *  @return 字符串
 */
-(NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel = nil;
    
    switch (logMessage->_flag) {
        case DDLogFlagError: {
            logLevel = @"[ERROR] > ";
            break;
        }
        case DDLogFlagWarning: {
            logLevel = @"[WARNING] > ";
            break;
        }
        case DDLogFlagInfo: {
            logLevel = @"[INFO] > ";
            break;
        }
        case DDLogFlagDebug: {
            logLevel = @"[DEBUG] > ";
            break;
        }
        case DDLogFlagVerbose: {
            logLevel = @"[VERBOSE] > ";
            break;
        }
    }
    
    return [NSString stringWithFormat:@"%@ %@%@" ,logMessage.timestamp, logLevel, logMessage->_message];
}

-(void)setLogLevel:(PYLogLevel)logLevel
{
    _logLevel = logLevel;
    switch (logLevel) {
        case PYLogLevelError: {
            ddLogLevel = DDLogLevelError;
            break;
        }
        case PYLogLevelInfo: {
            ddLogLevel = DDLogLevelInfo;
            break;
        }
        case PYLogLevelWarning: {
            ddLogLevel = DDLogLevelWarning;
            break;
        }
        case PYLogLevelOFF: {
            ddLogLevel = DDLogLevelOff;
            break;
        }
        case PYLogLevelDebug: {
            ddLogLevel = DDLogLevelDebug;
            break;
        }
        case PYLogLevelVerbose:{
            ddLogLevel = DDLogLevelVerbose;
        }
    }

}

/**
 *  带可变参数的日志
 *
 *  @param logLevel 日志等级
 *  @param formater 可变参数
 */
-(void)logLevel:(PYLogLevel)logLevel formater:(NSString *)formater,...
{
    if (formater) {
        va_list args;
        va_start(args, formater);
        NSString *message = [[NSString alloc]initWithFormat:formater arguments:args];
        va_end(args);
        [self logLevel:logLevel message:message];
    }
}

/**
 *  日志记录
 *
 *  @param logLevel 日志等级
 *  @param message  日志信息
 */
-(void)logLevel:(PYLogLevel)logLevel message:(NSString *)message
{
    if (message.length > 0) {
        switch (logLevel) {
            case PYLogLevelError: {
                DDLogError(@"%@", message);
                break;
            }
            case PYLogLevelInfo: {
                DDLogInfo(@"%@", message);
                break;
            }
            case PYLogLevelWarning: {
                DDLogWarn(@"%@", message);
                break;
            }
            case PYLogLevelOFF: {
                break;
            }
            case PYLogLevelDebug: {
                DDLogDebug(@"%@", message);
                break;
            }
            case PYLogLevelVerbose:{
                DDLogVerbose(@"%@",message);
            }
        }
    }
    
    
}



@end
