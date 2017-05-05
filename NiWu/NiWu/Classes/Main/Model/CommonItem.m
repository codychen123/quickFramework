/*!
 @header      CommonItem.m
 @abstract    我的cell项目
 @author      Created by 汪特龙 on 16/9/29
 @version     16/9/29
   Copyright © 2016年 peb. All rights reserved.
*/


#import "CommonItem.h"

@implementation CommonItem

+(instancetype)itemWithTitle:(NSString *)title detail:(NSString *)detail
{
    CommonItem *item =  [[self alloc ]init];
    item.title = title;
    item.detail = detail;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    CommonItem *item =  [[self alloc ]init];
    item.title = title;
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title typeClass:(Class)typeClass
{
    CommonItem *item =  [[self alloc ]init];
    item.title = title;
    item.typeClass = typeClass;
    return item;
}


+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon highlightIcon:(NSString *)highlightIcon
{
    CommonItem *item =  [[self alloc ]init];
    item.title = title;
    item.icon = icon;
    item.highlightIcon = highlightIcon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon highlightIcon:(NSString *)highlightIcon typeClass:(Class)typeClass
{
    CommonItem *item =  [[self alloc ]init];
    item.title = title;
    item.icon = icon;
    item.highlightIcon = highlightIcon;
    item.typeClass = typeClass;
    return item;
}
@end
