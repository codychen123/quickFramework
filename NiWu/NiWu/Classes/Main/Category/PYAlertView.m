//
//  PYAlertView.m
//  PEB
//
//  Created by hxt_025 on 2017/3/31.
//  Copyright © 2017年 peb. All rights reserved.
//

#import "PYAlertView.h"

@interface PYAlertView ()

@property (nonatomic, weak) MBProgressHUD *hud;

@end

static PYAlertView *_instance = nil;

@implementation PYAlertView

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)showMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeText;
        self.hud.label.text = message;
        [self.hud hideAnimated:YES afterDelay:1.0];
    });
}

- (void)showMessage:(NSString *)message detailMessage:(NSString *)detailMessage {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.hud.mode = MBProgressHUDModeText;
        self.hud.label.text = message;
        self.hud.detailsLabel.text = detailMessage;
        [self.hud hideAnimated:YES afterDelay:1.0];
    });
}

- (void)showMessage:(NSString *)message customView:(NSString *)imageName {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.hud.mode = MBProgressHUDModeCustomView;
        self.hud.label.text = message;
        self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self.hud hideAnimated:YES afterDelay:0.5];
    });
}

- (void)showloadingAnimationWithProgressMessage:(NSString *)message progress:(CGFloat)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        self.hud.label.text = message;
        self.hud.progress = progress;
    });
}

- (void)showloadingAnimationWithProgressMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.label.text = message;
    });
}

- (MBProgressHUD *)hud {
    if (_hud == nil) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
        hud.bezelView.backgroundColor = [UIColor darkGrayColor];
        //hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
        hud.contentColor = [UIColor whiteColor];
        _hud = hud;
    }
    return _hud;
}

- (void)dismiss{
    [self.hud hideAnimated:NO];
}

@end
