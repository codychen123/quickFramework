/*!
 @header      EditPageHeaderView.h
 @abstract    分页Menu头部视图
 @author      Created by 汪特龙 on 16/10/22
 @version     16/10/22
   Copyright © 2016年 peb. All rights reserved.
*/

#import <UIKit/UIKit.h>

@protocol EditPageHeaderViewDelegate <NSObject>

- (void)segmentValueChanged:(UISegmentedControl *)segment;

@end
@interface EditPageHeaderView : UIView

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) id<EditPageHeaderViewDelegate> delegate;
@end
