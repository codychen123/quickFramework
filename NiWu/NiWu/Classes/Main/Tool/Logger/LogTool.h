/*!
 @header      LogTool.h
 @abstract    日志记录工具
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PYLogLevel) {
  PYLogLevelError = 1,
  PYLogLevelInfo = 2,
  PYLogLevelWarning = 3,
  PYLogLevelOFF = 4,
  PYLogLevelDebug = 5,
  PYLogLevelVerbose = 6
};


#define PY_LOG_MACRO(level, fmt, ...)     [[LogTool shareInstance] logLevel:level formater:(fmt), ##__VA_ARGS__]
#define PY_LOG_PRETTY(level, fmt, ...)    \
do {PY_LOG_MACRO(level, @"%s #%d " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);} while(0)

#define PYLogError(frmt, ...)   PY_LOG_PRETTY(PYLogLevelError , frmt, ##__VA_ARGS__)
#define PYLogWarn(frmt, ...)    PY_LOG_PRETTY(PYLogLevelWarning , frmt, ##__VA_ARGS__ )
#define PYLogInfo(frmt, ...)    PY_LOG_PRETTY(PYLogLevelInfo , frmt , ##__VA_ARGS__ )
#define PYLogDebug(frmt, ...)   PY_LOG_PRETTY(PYLogLevelDebug , frmt , ##__VA_ARGS__ )
#define PYLog(frmt, ...)        PY_LOG_PRETTY(PYLogLevelDebug , frmt , ##__VA_ARGS__ )
@interface LogTool : NSObject
@property(nonatomic, assign) PYLogLevel logLevel;

+ (instancetype)shareInstance;

/**
 *  启动日志
 *
 *  @param logLevel 日志等级
 */
+ (void)startWithLogLevel:(PYLogLevel)logLevel;
/**
 *  带可变参数的日志
 *
 *  @param logLevel 日志等级
 *  @param formater 可变参数
 */
- (void)logLevel:(PYLogLevel)logLevel formater:(NSString *)formater, ...;

/**
 *  日志记录
 *
 *  @param logLevel 日志等级
 *  @param message  日志信息
 */
- (void)logLevel:(PYLogLevel)logLevel message:(NSString *)message;

@end
