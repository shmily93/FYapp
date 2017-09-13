//
//  RootViewController.m
//  FYapp
//
//  Created by fanyi on 2017/9/13.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

}

@end
