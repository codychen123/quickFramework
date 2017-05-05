//
//  ErrorView.h
//  XGXShop
//
//  Created by TeLong on 16/6/13.
//  Copyright © 2016年 peb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ErrorType) {
    ErrorTypeNoData     = 0,    //无数据
    ErrorTypeNoNetwork  = 1,    //无网络
    ErrorTypeNoOrders   = 2,    //无订单
    ErrorTypeNoRecord   = 3,    //无相关记录
    ErrorTypeNoShoppingCart     = 4, //购物车为空
    ErrorTypeNoRedWish    = 5 //无红包
    

};

@interface ErrorView : UIView
@property (nonatomic , assign) ErrorType type;
@end
