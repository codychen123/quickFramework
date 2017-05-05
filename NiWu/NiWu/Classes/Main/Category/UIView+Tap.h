//
//  UIView+Tap.h
//  PEB
//
//  Created by xiaohuihui on 2017/3/4.
//  Copyright © 2017年 peb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)

/**
 *  动态添加手势
 */
- (void)setTapActionWithBlock:(void (^)(void))block ;

@end
