/*!
 @header      CommonItem.h
 @abstract    我的cell项目
 @author      Created by 汪特龙 on 16/9/29
 @version     16/9/29
   Copyright © 2016年 peb. All rights reserved.
*/

#import <Foundation/Foundation.h>


@interface CommonItem : NSObject
/** 标题*/
@property (nonatomic , copy) NSString *title;
/** 详情*/
@property (nonatomic , copy) NSString *detail;
/** 图标*/
@property (nonatomic , copy) NSString *icon;
/** 类型*/
@property (nonatomic , assign) Class typeClass;
/** 高亮图标*/
@property (nonatomic , copy) NSString *highlightIcon;
/** placeholder image */
@property(nonatomic, copy) NSString *placeholderImg;
/** 开关是否打开*/
@property (nonatomic , assign , getter = isOpen) BOOL open;
/** 跳转到的控制器Class*/
@property (nonatomic , assign) Class descVcClass;
/** 需要进行的操作(Block)*/
@property (nonatomic , copy) void(^operation)();
/** 需要执行的方法*/
@property (nonatomic , assign) SEL selector;

+(instancetype)itemWithTitle:(NSString *)title detail:(NSString *)detail;

+(instancetype)itemWithTitle:(NSString *)title typeClass:(Class)typeClass;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon highlightIcon:(NSString *)highlightIcon;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon highlightIcon:(NSString *)highlightIcon typeClass:(Class)typeClass;
@end
