//
//  RootViewController.h
//  FYapp
//
//  Created by fanyi on 2017/9/13.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于切换登录和主页的控制器
@interface RootViewController : UIViewController

@property (nonatomic, readonly) UIViewController *currentVC;

+ (instancetype)shareInstance;
- (void)switchViewController:(UIViewController *)viewController
                  completion:(void(^)(BOOL finish))completion;

@end
