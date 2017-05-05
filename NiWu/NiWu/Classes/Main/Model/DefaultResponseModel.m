/*!
 @header      DefaultResponseModel.m
 @abstract    默认的响应参数
 @author      Created by 汪特龙 on 16/7/19
 @version     16/7/19
   Copyright © 2016年 peb. All rights reserved.
*/


#import "DefaultResponseModel.h"

@implementation DefaultResponseModel

- (NSString *)message{
    if (_message != nil){
        return _message;
    }else{
        return _errorMessage;
    }
}

@end
