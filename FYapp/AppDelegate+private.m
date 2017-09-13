//
//  AppDelegate+private.m
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "AppDelegate+private.h"

@implementation AppDelegate (private)

- (void)configurekeyboardManager {
    self.keyboardManager = [IQKeyboardManager sharedManager];
    self.keyboardManager.enable = YES;
    self.keyboardManager.shouldResignOnTouchOutside = YES;
    self.keyboardManager.keyboardDistanceFromTextField = 30;

}

@end
