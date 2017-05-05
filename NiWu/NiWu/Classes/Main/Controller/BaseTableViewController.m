//
//  BaseTableViewController.m
//  PEB
//
//  Created by Hee on 03/03/2017.
//  Copyright © 2017 peb. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@property (strong, nonatomic) ErrorView * errorView;

@end

@implementation BaseTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseUI];
    [self setupBaseData];
}

- (void)setupBaseUI {
    self.tableView.backgroundColor = BG_COLOR;
}

- (void)setupBaseData {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



#pragma mark - ErrorView

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo
{
    if (self.errorView == nil) {
        self.errorView = [[[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil] objectAtIndex:0];
        [self.errorView setFrame:self.view.bounds];
        [self.view addSubview:self.errorView];
    }
    self.errorView.type = type;
    self.errorView.hidden = NO;
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:todo];
    [self.errorView addGestureRecognizer:tapRec];
}

- (void)showErrorViewWithType:(ErrorType)type todo:(SEL)todo isMarginToTop :(BOOL)isMargin
{
    if (self.errorView == nil) {
        self.errorView = [[[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil] objectAtIndex:0];
        if (isMargin == YES) {
            [self.errorView setFrame:CGRectMake(0, 53, SCREEN_WIDTH,SCREEN_HEIGHT-53)];
            [self.view addSubview:self.errorView];
        }
        
    }
    self.errorView.type = type;
    self.errorView.hidden = NO;
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:todo];
    [self.errorView addGestureRecognizer:tapRec];
}

- (void)hideErrorView
{
    self.errorView.hidden = YES;
}

- (void)errorMessageShowViewWithString :(NSString *)message andBlock:(MMPopupItemHandler)block andItemTitles:(NSArray *)titles andItemCout:(NSInteger)count
{
    
    [MMAlertViewConfig globalConfig].itemHighlightColor = ORANGE_COLOR;
    [MMAlertViewConfig globalConfig].itemNormalColor = RGBA(47, 47, 47, 1);
    [MMAlertViewConfig globalConfig].titleFontSize = 17;
    [MMAlertViewConfig globalConfig].buttonHeight = 60;
    
    NSArray *items ;
    if (count == 2) {
        MMPopupItem *confirmItem = MMItemMake([titles firstObject], MMItemTypeHighlight, nil);
        MMPopupItem *cancelItem = MMItemMake([titles lastObject], MMItemTypeNormal, block);
        items = @[cancelItem,confirmItem];
    }else{
        MMPopupItem *confirmItem = MMItemMake([titles firstObject], MMItemTypeHighlight, nil);
        items = @[confirmItem];
    }
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:message detail:nil items:items];
    [alertView showWithBlock:nil];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = LINE_COLOR;
//    return lineView;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = LINE_COLOR;
//    return lineView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return SCREEN_RU(1.0);
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return SCREEN_RU(1.0);
//}
@end
