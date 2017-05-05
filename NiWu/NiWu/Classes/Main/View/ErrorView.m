//
//  ErrorView.m
//  XGXShop
//
//  Created by TeLong on 16/6/13.
//  Copyright © 2016年 peb. All rights reserved.
//

#import "ErrorView.h"

@interface ErrorView()
@property (weak, nonatomic) IBOutlet UIImageView *errorImageView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorDetailLabal;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginToTop;
@end
@implementation ErrorView



- (void)setType:(ErrorType)type
{
    _type = type;
    switch (type) {
        case ErrorTypeNoData: {
            self.errorImageView.image = [UIImage imageNamed:@"no_data"];
            self.errorLabel.text = @"无数据";
            self.errorDetailLabal.text = @"暂时无数据哦 , 点击图标刷新一下试试看";
            break;
        }
        case ErrorTypeNoNetwork: {
            self.errorImageView.image = [UIImage imageNamed:@"no_network"];
            self.errorLabel.text = @"无网络";
            self.errorDetailLabal.text = @"无法连接网络 , 请检查网络并刷新重试";
            break;
        }
        case ErrorTypeNoOrders: {
            self.errorImageView.image = [UIImage imageNamed:@"no_orders"];
            self.errorLabel.text = @"没有订单";
            self.errorDetailLabal.text = @"您还没有订单哦 , 快去商城逛逛吧~";
            break;
        }
        case ErrorTypeNoRecord: {
            self.errorImageView.image = [UIImage imageNamed:@"no_record"];
            self.errorLabel.text = @"没有相关记录";
            self.errorDetailLabal.text = @"您还没有相关记录哦~";
            break;
        }
        case ErrorTypeNoShoppingCart: {
            self.errorImageView.image = [UIImage imageNamed:@"shopping_cart"];
            self.errorLabel.text = @"购物车";
            self.errorDetailLabal.text = @"购物车空空如也 , 快去商城逛逛吧";
            break;
        }
        case ErrorTypeNoRedWish: {
            self.errorImageView.image = [UIImage imageNamed:@"no_redwish"];
            self.errorLabel.text = @"暂时没有红包";
            self.backgroundColor = [UIColor clearColor];
            break;
        }
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil] firstObject];
    }
    return self;
}

- (instancetype)initWithType:(ErrorType)type
{
    self = [self initWithFrame:KEY_WINDOW.frame];
    self.type = type;
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.hidden = YES;
}

@end
