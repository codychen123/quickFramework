/*!
 @header      BaseTableViewHeaderFooterView.h
 @abstract    <#关于源代码的基本描述#>
 @author      Created by <#名称#> on 2017/3/4
 @version     2017/3/4
   Copyright © 2017年 peb. All rights reserved.
*/

#import <UIKit/UIKit.h>

@interface BaseTableViewHeaderFooterView : UITableViewHeaderFooterView

/**
 *  快速创建一个不是从xib中加载的tableview header footer
 */
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;
/**
 *  快速创建一个从xib中加载的tableview header footer
 */
+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
