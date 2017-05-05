/*!
 @header      BaseTableViewCell.m
 @abstract    source code
 @author      Created by PEB on 2017/3/4
 @version     2017/3/4
 Copyright © 2017年 peb. All rights reserved.
 */


#import "BaseTableViewCell.h"


@interface BaseTableViewCell ()
@property(nonatomic, assign) CGSize size;
@end

@implementation BaseTableViewCell

- (UITableView *)tableView {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        return  (UITableView *)self.superview.superview;
    } else {
        return (UITableView *)self.superview;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifier = classname;
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}


+ (__kindof UITableViewCell *)nibCellWithTableView:(UITableView *)tableView {
    id cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    }
    return cell;
}

/**
 *  快速创建一个cell通过identifier
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] init];
    }
    return cell;
}
- (void)customSize:(CGSize)size{
    self.size = size;
    [self layoutIfNeeded];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.size.height > 0 && self.size.width > 0) {
        self.imageView.frame = CGRectMake(18, self.height*0.5-self.size.height*0.5, self.size.width, self.size.height);
        self.textLabel.frame = CGRectMake(self.imageView.width + self.imageView.x + 5, self.height*0.5-self.textLabel.height*0.5, self.textLabel.width, self.textLabel.height);
    }
}

@end
