//
//  AppDelegate+private.m
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "AppDelegate+private.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import <M9Dev/M9Dev.h>

@implementation AppDelegate (private)

- (void)configurekeyboardManager {
    self.keyboardManager = [IQKeyboardManager sharedManager];
    self.keyboardManager.enable = YES;
    self.keyboardManager.shouldResignOnTouchOutside = YES;
    self.keyboardManager.keyboardDistanceFromTextField = 30;

}

- (void)setupViewControllers {
    //如果已登录就进入主页，否则展示登录页面
    LoginViewController *loginVC = [LoginViewController new];
    UINavigationController *navi = [UINavigationController navigationControllerWithRootViewController:loginVC];
    [[RootViewController shareInstance] switchViewController:navi completion:nil];

}
@end
