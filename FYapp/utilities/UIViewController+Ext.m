//
//  UIViewController+Ext.m
//  FYapp
//
//  Created by fanyi on 2017/9/14.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "UIViewController+Ext.h"

@implementation UIViewController (Ext)

- (void)ext_addChildViewController:(UIViewController *)viewController {
    if(!viewController || !viewController.view) {
        return;
    }
    
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)ext_removeFromParentViewControllerAndSuperview {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
