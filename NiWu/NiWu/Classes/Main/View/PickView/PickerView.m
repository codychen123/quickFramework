//
//  PickerView.m
//
//  Created by aTeLong on 16/5/24.
//  Copyright © 2016年 . All rights reserved.
//

#import "PickerView.h"

#define PICKER_MONTH 12
#define PICKER_HOUR 24
/** 屏幕 */
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
#define WINDOW_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
/** 颜色和透明度设置 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a]

@interface PickerView () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) UIDatePicker * datePicker;
@property (strong, nonatomic) UIPickerView * areaPicker;
@property (strong, nonatomic) UIPickerView * defaultPickerView;

@property (copy, nonatomic) NSString * dateStr;
@property (copy, nonatomic) NSMutableString * areaStr;

@property (strong, nonatomic) UIView * pickerView;
@property (strong, nonatomic) UIView * bottomView;

@property (assign, nonatomic) PickerMode pickerMode;

@property (strong, nonatomic) NSDictionary * areaDic;
@property (strong, nonatomic) NSArray * province;
@property (strong, nonatomic) NSArray * city;
@property (strong, nonatomic) NSArray * district;

@property (assign, nonatomic) NSInteger monthIndex;
@property (assign, nonatomic) NSInteger dayIndex;
@property (assign, nonatomic) NSInteger hourIndex;


@property (strong, nonatomic) NSMutableArray *monthArr;
@property (strong, nonatomic) NSMutableArray *dayArr;
@property (strong, nonatomic) NSMutableArray *hourArr;



@end

@implementation PickerView

- (NSMutableString *)areaStr
{
    if(_areaStr == nil){
        _areaStr = [NSMutableString string];
    }
    return _areaStr;
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self.defaultPickerView reloadAllComponents];
}


- (instancetype)initWithPickerMode:(PickerMode)pickerMode delegate:(id<PickerViewDelegate>)delegate;
{
    self = [self initWithFrame:WINDOW_FRAME];
    if (self) {
        _pickerMode = pickerMode;
        _delegate = delegate;
        _bottomView = [[UIView alloc] initWithFrame:WINDOW_FRAME];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0;
        [KEY_WINDOW addSubview:_bottomView];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
        [_bottomView addGestureRecognizer:tap];
        _bottomView.hidden = YES;
        
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT + 220, SCREEN_WIDTH, 220)];
        _pickerView.backgroundColor = RGBA(238, 238, 238, 1);
        _pickerView.userInteractionEnabled = YES;
        [KEY_WINDOW addSubview:_pickerView];
        
        
        _defaultPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 180)];
        _defaultPickerView.backgroundColor = [UIColor whiteColor];
        _defaultPickerView.dataSource = self;
        _defaultPickerView.delegate = self;
        [_pickerView addSubview:_defaultPickerView];
        
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = RGBA(255, 255, 255, 0.4);
        [_pickerView addSubview:lineView];
        
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(10, 10, 60, 30);
        [cancelBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        [cancelBtn setTitleColor:RGBA(115, 115, 115, 1) forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.layer.cornerRadius = cancelBtn.frame.size.height * 0.25;
        cancelBtn.layer.borderWidth = 1.0;
        cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cancelBtn.layer.masksToBounds = YES;
        [_pickerView addSubview:cancelBtn];
        
        UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(SCREEN_WIDTH - 60 - 10, 10, 60, 30);
        [doneBtn setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
        [doneBtn setBackgroundColor:MAIN_RED_COLOR];
        doneBtn.layer.cornerRadius = doneBtn.frame.size.height * 0.25;
        doneBtn.layer.masksToBounds = YES;
        [_pickerView addSubview:doneBtn];
        
        self.selectIndex = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self initData];
    }
    return self;
}

//- (void)initData
//{
//    _monthArr = [NSMutableArray array];
//    _dayArr = [NSMutableArray array];
//    _hourArr = [NSMutableArray array];
//    
//    for (int i = 0; i < PICKER_MONTH; i++) {
//        
//        NSString *key = [NSString stringWithFormat:@"%i",i + 1];
//        NSString *value = [NSString stringWithFormat:@"%02i月",i + 1];
//        NSDictionary *dict = @{ key : value };
//        [_monthArr addObject:dict];
//        
//        for (int j = 0; j < [self howManyDaysInThisYear:[[NSDate date] year] withMonth:i + 1]; j ++ ) {
//           
//            NSString *key = [NSString stringWithFormat:@"%i",j + 1];
//            NSString *value = [NSString stringWithFormat:@"%02i日",j + 1];
//            NSDictionary *dict = @{ key : value };
//            [_dayArr addObject:dict];
//        }
//    }
//    
//    for (int i = 0; i < PICKER_HOUR; i++) {
//        NSString *key = [NSString stringWithFormat:@"%i",i];
//        NSString *value = [NSString stringWithFormat:@"%02i时",i];
//        NSDictionary *dict = @{ key : value };
//        [_hourArr addObject:dict];
//    }
//}

- (void)cancelClick
{
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.hidden = YES;
        _bottomView.alpha = 0;
        _pickerView.frame  = CGRectMake(0, SCREEN_HEIGHT + 220, SCREEN_WIDTH, 220);
    }];
    
    if ([_delegate respondsToSelector:@selector(pickerViewCancelView:)]) {
        [_delegate pickerViewCancelView:self];
    }
}

- (void)doneClick
{
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.hidden = YES;
        _bottomView.alpha = 0;
        _pickerView.frame  = CGRectMake(0, SCREEN_HEIGHT + 220, SCREEN_WIDTH, 220);
    }];
    switch (_pickerMode) {
        case PickerModeTime:
        {
            NSDate * selectDate = [_datePicker date];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([_delegate respondsToSelector:@selector(pickerViewSelectDate:)]) {
                [_delegate pickerViewSelectDate:[dateFormatter stringFromDate:selectDate]];
            }
        }
            break;
        case PickerModeDate:
        {
            NSDate * selectDate = [_datePicker date];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            if ([_delegate respondsToSelector:@selector(pickerViewSelectDate:)]) {
                [_delegate pickerViewSelectDate:[dateFormatter stringFromDate:selectDate]];
            }
        }
            break;
        case PickerModeDefault:
        {
            if ([_delegate respondsToSelector:@selector(pickerViewSelectIndex:)]) {
                [_delegate pickerViewSelectIndex:self.selectIndex];
            }
            if ([_delegate respondsToSelector:@selector(pickerViewSelectIndex:view:)]){
                 [_delegate pickerViewSelectIndex:self.selectIndex view:self];
            }
        }
            break;

        default:
            break;
    }
}

- (void)showPickerView
{
    [self.defaultPickerView selectRow:0 inComponent:0 animated:NO];
    self.selectIndex = 0;
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.hidden = NO;
        _bottomView.alpha = 0.4;
        _pickerView.frame  = CGRectMake(0, SCREEN_HEIGHT - 220, SCREEN_WIDTH, 220);
    }];
}


#pragma mark - UIPickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    if(self.pickerMode == PickerModeArea){
//        if (component == 0) {
//            return [_province count];
//        } else if (component == 1) {
//            return [_city count];
//        } else {
//            return [_district count];
//        }
//    }else{
//        NSDate *nowDate = [NSDate date];
//        if (component == 0) return 12;
//        if (component == 1) return [self howManyDaysInThisYear:[nowDate year] withMonth:_monthIndex + 1];
//        if (component == 2) return 24;
        return self.dataArr.count;
//    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.frame.size.width / 3;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectIndex = row;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * pickerLabel = (UILabel*)view;
    if (pickerLabel == nil){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 21);
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20.0]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.dataArr[row];
}


@end
