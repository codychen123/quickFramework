//
//  PickerView.h
//
//  Created by aTeLong on 16/5/24.
//  Copyright © 2016年 . All rights reserved.
//


#import <UIKit/UIKit.h>
@class PickerView;

typedef enum : NSUInteger {
    PickerModeDefault = 0,
    PickerModeDate = 1,
    PickerModeTime = 2,
    PickerModeArea = 3,
} PickerMode;
@protocol PickerViewDelegate <NSObject>
@optional
- (void)pickerViewSelectDate:(NSString *)dateStr;
- (void)pickerViewSelectIndex:(NSInteger)index view:(PickerView *)view;
- (void)pickerViewSelectIndex:(NSInteger)index ;

- (void)pickerViewCancelView:(PickerView *)view;//点击取消
@end

@interface PickerView : UIView

@property (assign, nonatomic) id<PickerViewDelegate> delegate;
@property (strong, nonatomic) NSArray *dataArr;
@property (assign, nonatomic) NSInteger selectIndex;

- (instancetype)initWithPickerMode:(PickerMode)pickerMode delegate:(id<PickerViewDelegate>)delegate;

- (void)showPickerView;

@end
