//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  PEB
//
//  Created by xiaohuihui on 2017/3/10.
//  Copyright © 2017年 peb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
