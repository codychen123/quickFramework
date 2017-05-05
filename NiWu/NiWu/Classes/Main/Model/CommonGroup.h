/*!
 @header      CommonGroup.h
 @abstract    source code
 @author      Created by 汪特龙 on 16/5/31
 @version     16/5/31
 Copyright © 2016年 Lun. All rights reserved.
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , CommonGroupType) {
    CommonGroupTypeNormal,
    CommonGroupTypeShopHeader
};

@interface CommonGroup : NSObject
/** 组头*/
@property (nonatomic , copy) NSString *header;
/** 组尾*/
@property (nonatomic , copy) NSString *footer;
/** 保存模型*/
@property (nonatomic , strong) NSMutableArray *items;
/** 组头类型*/
@property (nonatomic , assign) CommonGroupType type;
+(instancetype)group;
@end
