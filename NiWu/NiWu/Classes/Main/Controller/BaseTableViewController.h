//
//  BaseTableViewController.h
//  PEB
//
//  Created by Hee on 03/03/2017.
//  Copyright © 2017 peb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeader.h"
#import "RefreshFooter.h"

@interface BaseTableViewController : UITableViewController

- (void)setupBaseUI;
- (void)setupBaseData;

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo;

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo isMarginToTop :(BOOL)isMargin;

- (void)hideErrorView;

- (void)pushStoryboard:(NSString *)sbname withId:(NSString *)name;
@end
