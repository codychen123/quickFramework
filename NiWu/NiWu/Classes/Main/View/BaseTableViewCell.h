/*!
 @header      BaseTableViewCell.h
 @abstract    基类cell
 @author      Created by huihui on 2017/3/4
 @version     2017/3/4
   Copyright © 2017年 peb. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, weak) UITableView *tableView;

/**
 *  快速创建一个不是从xib中加载的tableview cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  快速创建一个从xib中加载的tableview cell
 */
+ (__kindof UITableViewCell *)nibCellWithTableView:(UITableView *)tableView ;

/**
 *  快速创建一个cell通过identifier
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

/// custom cell imageview size
- (void)customSize:(CGSize)size;
@end
