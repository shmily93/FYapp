//
//  MBProgressHUD+Ext.h
//  FYapp
//
//  Created by fanyi on 2017/9/14.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

static const NSTimeInterval ProgressHudTimeInterval = 2.0;

@interface MBProgressHUD (Ext)

//失败的loading,ProgressHudTimeInterval后消失
- (void)showErrorLoadingThenHide:(NSString *)message;
- (void)showErrorLoadingThenHide:(NSString *)message completionHandler:(void(^)())completionHandler;
+ (void)showErrorLoadingThenHide:(NSString *)message toView:(UIView *)view completionHandler:(void(^)())completionHandler;

//成功的loading,ProgressHudTimeInterval后消失
- (void)showSuccLoadingThenHide:(NSString *)message;
- (void)showSuccLoadingThenHide:(NSString *)message completionHandler:(void(^)())completionHandler;
+ (void)showSuccLoadingThenHide:(NSString *)message toView:(UIView *)view completionHandler:(void(^)())completionHandler;

//普通 Loading,ProgressHudTimeInterval后消失
+ (void)showLoadingWithMessageThenHide:(NSString *)msg toView:(UIView*)view;
+ (void)showLoadingWithMessageThenHide:(NSString *)msg toView:(UIView *)view onHide:(void (^)())onHide;


//loading和关闭loading
+ (MBProgressHUD *)showLoading:(NSString *)message toView:(UIView *)view;
+ (void)closeLoadinginView:(UIView *)view;

@end
