//
//  UIViewController+Ext.h
//  FYapp
//
//  Created by fanyi on 2017/9/14.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Ext)

- (void)ext_addChildViewController:(UIViewController *)viewController;

- (void)ext_removeFromParentViewControllerAndSuperview;
@end
