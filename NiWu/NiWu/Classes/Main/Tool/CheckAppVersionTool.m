//
//  CheckAppVersionTool.m
//  PEB
//
//  Created by hxt_025 on 2017/3/24.
//  Copyright © 2017年 peb. All rights reserved.
//

#import "CheckAppVersionTool.h"

@implementation CheckAppVersionTool

+ (CheckAppVersionTool *)sharedInstance {
    
    static CheckAppVersionTool * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[CheckAppVersionTool alloc] init];
        }
    });
    return sharedInstance;
}

- (void)setIsShow:(BOOL)isShow {

    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"isShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isShow {

    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isShow"];
}

- (BOOL)checkAppVessionIsEqualToCurrentVersion:(NSString *)currentVersion showVersion:(NSString *)showVersion urlToAppStore:(NSString *)newVersionUrl message:(NSString *)message{

    self.updateUrl = newVersionUrl;
    NSString *messageStr = message;
    //获取设备中应用的版本号
    NSString *oldVersion = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    //判断两个版本是否相同  NSOrderedDescending升序
    if ([currentVersion compare:oldVersion options:NSNumericSearch] == NSOrderedDescending) {
        
        [self setIsShow:1];
        NSString *titleStr = [NSString stringWithFormat:@"温馨提示"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        alert.tag = 100;
        [alert show];
    }else if ([currentVersion isEqualToString:oldVersion]){
        [self setIsShow:1];
    }else {
        [self setIsShow:0];
    }
    return [self isShow];
}

//判断用户点击了哪一个按钮
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   
    if (alertView.tag == 100) {
        if (buttonIndex == 1) { //点击”升级“按钮，就从打开app store上应用的详情页面
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
        }
    }
}

@end
