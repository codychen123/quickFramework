//
// Created by Hee on 06/03/2017.
// Copyright (c) 2017 peb. All rights reserved.
//

#import "Alert.h"


@implementation Alert

+ (void)alertTitle:(NSString *)title  message:(NSString *)msg okBtnTouch:(CommonBlockVoid)block{
        UIAlertController *alertController;
        alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (block) {
                block(action);
            }
        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
    [KEY_WINDOW.rootViewController presentViewController:alertController animated:YES completion:nil];
    }

+ (void)alertTitle:(NSString *)title  message:(NSString *)msg isNeedCancel:(BOOL)isNeedCancel okBtnTouch:(CommonBlockVoid)block {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    //改变title的大小和颜色
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, title.length)];
    [titleAtt addAttribute:NSForegroundColorAttributeName value:MAIN_TEXT_COLOR range:NSMakeRange(0, title.length)];
    [alertController setValue:titleAtt forKey:@"attributedTitle"];
    //改变message的大小和颜色
    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:msg];
    [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, msg.length)];
    [messageAtt addAttribute:NSForegroundColorAttributeName value:MAIN_TEXT_COLOR range:NSMakeRange(0, msg.length)];
    [alertController setValue:messageAtt forKey:@"attributedMessage"];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (block) {
            block(action);
        }
    }]];
    
    if (isNeedCancel) {
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    [KEY_WINDOW.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
