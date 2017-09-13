//
//  AppDelegate.h
//  FYapp
//
//  Created by fanyi on 2017/9/5.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) IQKeyboardManager *keyboardManager;

@end

