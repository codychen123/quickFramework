/*!
 @header      AppConstant.h
 @abstract    项目常用常量定义类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
   Copyright © 2017年 peb. All rights reserved.
 */

#ifndef AppConstant_h

/** 屏幕 */
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
#define WINDOW_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
// 以iPhone 6为标准尺寸计算比例
#define SCREEN_RU(pt)  ((pt) * (SCREEN_WIDTH / 375.0))

/**
 *  手机尺寸
 */
#define ThreeInch ([UIScreen mainScreen].bounds.size.height == 480.0)
#define FourInch ([UIScreen mainScreen].bounds.size.height == 568.0)
#define FiveInch ([UIScreen mainScreen].bounds.size.height == 667.0)
#define PlusInch ([UIScreen mainScreen].bounds.size.height == 736.0)

#define NAVIGATIONBAR_HEIGHT 44
#define STATUS_HEIGHT 20
#define TABBAR_HEIGHT 49
#define TOOLBAR_HEIGHT 44

/** 间距*/
#define DEFAULT_MARGIN 17.5

/** 颜色和透明度设置 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 常用颜色 */
#define MAIN_RED_COLOR UIColorFromRGB(0xcc0f25)
#define BACKGROUND_COLOR UIColorFromRGB(0xf6f9fc)
#define LINE_COLOR UIColorFromRGB(0xe1e3e5)
#define GREED_COLOR UIColorFromRGB(0x1e9b7f)

#define ORANGE_COLOR RGBA(255, 148, 48, 1)

#define MAIN_COLOR UIColorFromRGB(0xcc0f25)
#define BG_COLOR UIColorFromRGB(0xf6f9fc)
#define SEPARATOR_COLOR UIColorFromRGB(0xe1e3e5)
#define TITLE_COLOR UIColorFromRGB(0x666666)
#define MAIN_TEXT_COLOR UIColorFromRGB(0x333333)
#define SECONDARY_TEXT_COLOR UIColorFromRGB(0x999999)


/** 导航栏的颜色*/
#define NAV_GRAY_COLOR UIColorFromRGB(0x151516)
#define NAV_TINT_COLOR RGBA(102,102,102,1)
#define NAV_TEXT_COLOR RGBA(255, 255, 255 , 1)

/* 常用字体 */
#define DEFAULTFONT @"Avenir-Medium"
#define LIGHTFONT @"Avenir-Light"
#define PINGFANGFONT @"PingFangSC-Regular"
#define PINGFANGBOLDFONT @"PingFangSC-Semibold"

#define FONTSIZE_BUTTON [UIFont systemFontOfSize:16]
#define FONTSIZE_TEXT [UIFont systemFontOfSize:15]

/* 默认每页显示条数(分页)*/
#define kDefaultPageSize 10
/* 默认初始页码(分页)*/
#define kDefaultStartPageNo 1

#define kPlaceHolderImageName @"system_placeholder"

/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
#define kLineHeight (1 / [UIScreen mainScreen].scale)

#pragma mark - 字符串转化
#define kEmptyStr @""
#define kIntToStr(i) [NSString stringWithFormat: @"%d", i]
#define kIntegerToStr(i) [NSString stringWithFormat: @"%ld", i]
#define kValidStr(str) [NHUtils validString:str]

#define ONE_PIXEL_HEIGHT 1.0/[UIScreen mainScreen].scale

/**
 *  弱指针
 */
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kURL(string) [NSURL URLWithString:string]

#define L(name) NSLocalizedString(name, nil)

typedef void (^CommonBlockVoid)(id obj);
typedef id (^CommonBlock)(id obj);

#endif
