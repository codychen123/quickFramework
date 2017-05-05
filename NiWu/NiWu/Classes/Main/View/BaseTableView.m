/*!
 @header      BaseTableView.m
 @abstract    source code
 @author      Created by PEB on 2017/3/4
 @version     2017/3/4
   Copyright © 2017年 peb. All rights reserved.
*/


#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/** 注册普通的UITableViewCell*/
- (void)hh_registerCellClass:(Class)cellClass identifier:(NSString *)identifier {
    if (cellClass && identifier.length) {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}
/** 注册一个从xib中加载的UITableViewCell*/
- (void)hh_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier {
    if (cellNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[cellNib description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:nibIdentifier];
    }
}

/** 注册一个普通的UITableViewHeaderFooterView*/
- (void)hh_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier {
    if (headerFooterClass && identifier.length) {
        [self registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:identifier];
    }
}
/** 注册一个从xib中加载的UITableViewHeaderFooterView*/
- (void)hh_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier {
    if (headerFooterNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[headerFooterNib description] bundle:nil];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:nibIdentifier];
    };
}

- (void)hh_updateWithUpdateBlock:(void (^)(BaseTableView *tableView))updateBlock {
    if (updateBlock) {
        [self beginUpdates];
        updateBlock(self);
        [self endUpdates];
    }
}
- (UITableViewCell *)hh_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) return nil;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
        return nil;
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
        return nil;
    }
    return [self cellForRowAtIndexPath:indexPath];
}
/** 刷新单行、动画默认*/
- (void)hh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hh_reloadSingleRowAtIndexPath:indexPath animation:None];
}
- (void)hh_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 刷新多行、动画默认*/
- (void)hh_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self hh_reloadRowsAtIndexPaths:indexPaths animation:None];
}
- (void)hh_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BaseTableViewRowAnimation)animation {
    if (!indexPaths.count) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf hh_reloadSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 刷新某个section、动画默认*/
- (void)hh_reloadSingleSection:(NSInteger)section {
    [self hh_reloadSingleSection:section animation:None];
}
- (void)hh_reloadSingleSection:(NSInteger)section animation:(BaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 刷新多个section、动画默认*/
- (void)hh_reloadSections:(NSArray <NSNumber *>*)sections {
    [self hh_reloadSections:sections animation:None];
}
- (void)hh_reloadSections:(NSArray<NSNumber *> *)sections animation:(BaseTableViewRowAnimation)animation {
    if (!sections.count) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf hh_reloadSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 删除单行、动画默认*/
- (void)hh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hh_deleteSingleRowAtIndexPath:indexPath animation:Fade];
}
- (void)hh_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    
    NSLog(@"sectionNumber %ld  section%ld rowNumber%ld",sectionNumber, section , rowNumber);
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"删除section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"删除row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 删除多行、动画默认*/
- (void)hh_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self hh_deleteRowsAtIndexPaths:indexPaths animation:Fade];
}
- (void)hh_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BaseTableViewRowAnimation)animation {
    if (!indexPaths.count) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf hh_deleteSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 删除某个section、动画默认*/
- (void)hh_deleteSingleSection:(NSInteger)section {
    
    [self hh_deleteSingleSection:section animation:Fade];
}
- (void)hh_deleteSingleSection:(NSInteger)section animation:(BaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 删除多个section*/
- (void)hh_deleteSections:(NSArray *)sections {
    [self hh_deleteSections:sections animation:Fade];
}
- (void)hh_deleteSections:(NSArray<NSNumber *> *)sections animation:(BaseTableViewRowAnimation)animation {
    if (!sections.count) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf hh_deleteSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 增加单行 动画无*/
- (void)hh_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hh_insertSingleRowAtIndexPath:indexPath animation:None];
}
/** 增加单行，动画自定义*/
- (void)hh_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(BaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (section > sectionNumber || section < 0) {
        // section 越界
        NSLog(@"section 越界 : %ld", section);
    } else if (row > rowNumber || row < 0) {
        NSLog(@"row 越界 : %ld", row);
    } else {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
    
}

/** 增加单section，动画无*/
- (void)hh_insertSingleSection:(NSInteger)section {
    [self hh_insertSingleSection:section animation:None];
}
/** 增加单section，动画自定义*/
- (void)hh_insertSingleSection:(NSInteger)section animation:(BaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) {
        // section越界
        NSLog(@" section 越界 : %ld", section);
    } else {
        [self beginUpdates];
        [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 增加多行，动画无*/
- (void)hh_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self hh_insertRowsAtIndexPaths:indexPaths animation:None];
}
/** 增加多行，动画自定义*/
- (void)hh_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(BaseTableViewRowAnimation)animation {
    if (indexPaths.count == 0) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf hh_insertSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 增加多section，动画无*/
- (void)hh_insertSections:(NSArray <NSNumber *>*)sections {
    [self hh_insertSections:sections animation:None];
}
/** 增加多section，动画默认*/
- (void)hh_insertSections:(NSArray <NSNumber *>*)sections animation:(BaseTableViewRowAnimation)animation {
    if (sections.count == 0) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf hh_insertSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 当有输入框的时候 点击tableview空白处，隐藏键盘*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return view;
}

@end
