//
//  MBProgressHUD+Ext.m
//  FYapp
//
//  Created by fanyi on 2017/9/14.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "MBProgressHUD+Ext.h"

@implementation MBProgressHUD (Ext)


//失败的loading,ProgressHudTimeInterval后消失
- (void)showErrorLoadingThenHide:(NSString *)message {
   [self showErrorLoadingThenHide:message completionHandler:nil];
}
- (void)showErrorLoadingThenHide:(NSString *)message completionHandler:(void(^)())completionHandler {
    [self showLoadingWithImage:[UIImage imageNamed:@"error_icon"] message:message delay:ProgressHudTimeInterval onHide:completionHandler];
}

+ (void)showErrorLoadingThenHide:(NSString *)message toView:(UIView *)view completionHandler:(void(^)())completionHandler {
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    NSAssert1(view!=nil, @"loading View 没有找到", __FUNCTION__);
    
    if(view == nil) {
        
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if(!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    [hud showErrorLoadingThenHide:message completionHandler:completionHandler];
}

//成功的loading,ProgressHudTimeInterval后消失
- (void)showSuccLoadingThenHide:(NSString *)message {
    [self showSuccLoadingThenHide:message completionHandler:nil];
}

- (void)showSuccLoadingThenHide:(NSString *)message completionHandler:(void(^)())completionHandler {
    [self showLoadingWithImage:[UIImage imageNamed:@"succ_icon"] message:message delay:ProgressHudTimeInterval onHide:completionHandler];
}

+ (void)showSuccLoadingThenHide:(NSString *)message toView:(UIView *)view completionHandler:(void(^)())completionHandler {
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    NSAssert1(view!=nil, @"loading View 没有找到", __FUNCTION__);
    
    if(view == nil) {
        
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if(!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }

    [hud showLoadingWithImage:[UIImage imageNamed:@"succ_icon"] message:message delay:ProgressHudTimeInterval onHide:completionHandler];
}

//文字 Loading,ProgressHudTimeInterval后消失
+ (void)showLoadingWithMessageThenHide:(NSString *)msg toView:(UIView*)view {
    [self showLoadingWithMessageThenHide:msg toView:view onHide:nil];
}

+ (void)showLoadingWithMessageThenHide:(NSString *)msg toView:(UIView *)view onHide:(void (^)())onHide {
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    NSAssert1(view!=nil, @"loading View 没有找到", __FUNCTION__);
    
    if(view == nil) {
        
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if(!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
//    hud.detailsLabel.text = msg;
//    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabelText = msg;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;

    [hud hide:YES afterDelay:2];
    
    if(onHide) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            onHide();
        });
    }
}

//loading和关闭loading
+ (MBProgressHUD *)showLoading:(NSString *)message toView:(UIView *)view {
    if(view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    NSAssert1(view!=nil, @"loading View 没有找到", __FUNCTION__);

    if(view == nil) {
        
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if(!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
//    hud.detailsLabel.text = message;
//    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];

    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)closeLoadinginView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if(hud) {
        [hud hide:YES];
    }
}

#pragma mark - private
- (void)showLoadingWithImage:(UIImage *)image message:(NSString *)message delay:(float)delay onHide:(void(^)())onHide {
    if(image == nil) {
        [self hide:YES];
        if(onHide) {
            onHide();
        }
        return;
    }
    
    MBProgressHUD *hud = self;
//    hud.detailsLabel.text = nil;
//    hud.label.text = nil;
    
    hud.userInteractionEnabled = false;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
//    hud.opacity = 0.7;
//    hud.dimBackground = NO;

    UIView *customView = [UIView new];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [customView addSubview:imageView];
    CGRect imageFrame = imageView.frame;
    imageFrame.origin.y = 0;
    imageView.frame = imageFrame;
    
    UILabel *textLabel = [UILabel new];
    textLabel.text = message;
    textLabel.numberOfLines = 0;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.textColor = [UIColor whiteColor];
    
    CGSize textSize;
    if([message respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        CGRect frame = [message boundingRectWithSize:CGSizeMake(220, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[textLabel font]} context:nil];
        textSize = frame.size;
    }
    else {
        //sizeWithFont:……方法，在iOS 7以后被废弃
        textSize = [message sizeWithFont:[textLabel font] forWidth:220 lineBreakMode:NSLineBreakByClipping];
    }
    
    CGFloat strikeWidth = textSize.width;
    CGFloat height = textSize.height > 13 ? textSize.height: 13;
    textLabel.frame = CGRectMake(5, CGRectGetMaxY(imageFrame) + 5, strikeWidth, height);
    customView.frame = CGRectMake(0, 0, 5 + strikeWidth, CGRectGetMaxY(textLabel.frame));
    [customView addSubview:textLabel];
    
    imageFrame.origin.x = (customView.frame.size.width - imageFrame.size.width)/2;
    imageView.frame = imageFrame;
    
    hud.customView = customView;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
    
    if(onHide) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            onHide();
        });
    }
}
@end
