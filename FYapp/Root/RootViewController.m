//
//  RootViewController.m
//  FYapp
//
//  Created by fanyi on 2017/9/13.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewController+Ext.h"

@interface RootViewController ()

@property (nonatomic, readwrite) UIViewController *currentVC;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - public 
+ (instancetype)shareInstance {
    static RootViewController * rootVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVC = [RootViewController new];
    });
    return rootVC;
}

- (void)switchViewController:(UIViewController *)viewController
                  completion:(void(^)(BOOL finish))completion {
    
    if(!self.currentVC) {
        [self ext_addChildViewController:viewController];
        
        self.currentVC = viewController;
        [self setNeedsStatusBarAppearanceUpdate];
        [UIViewController attemptRotationToDeviceOrientation];
        if(completion) {
            completion(YES);
        }
        return;
    }
    
    [UIView transitionFromView:self.currentVC.view
                        toView:viewController.view
                      duration:5.0
                       options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionAutoreverse
                    completion:^(BOOL finished) {
                        [self.currentVC ext_removeFromParentViewControllerAndSuperview];
                        [self ext_addChildViewController:viewController];
                        
                        self.currentVC = viewController;
                        [self setNeedsStatusBarAppearanceUpdate];
                        [UIViewController attemptRotationToDeviceOrientation];
                        if(completion) {
                            completion(YES);
                        }
                    }];
}

/*
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.currentVC;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.currentVC;
}

- (BOOL)shouldAutorotate {
    // NSLog(@"shouldAutorotate: %d - %@", shouldAutorotate, self.activeViewController);
    return (self.currentVC
            ? [self.currentVC shouldAutorotate]
            : [super shouldAutorotate]);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    // NSLog(@"orientations: %d - %@", orientations, self.activeViewController);
    return (self.currentVC
            ? [self.currentVC supportedInterfaceOrientations]
            : [super supportedInterfaceOrientations]);
}
*/
@end
