//
//  AppConfig.m
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

+(instancetype)shareInstance {
    static AppConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[AppConfig alloc] init];
    });
    return config;
}

- (NSURL *)baseURL {
    
#if DEBUG
    switch (self.deployType) {
        case DeployType_test:
            return [NSURL URLWithString:@"test"];
        case DeployType_beta:
            return [NSURL URLWithString:@"beta"];
        default:
            break;
    }
#endif
    return [NSURL URLWithString:@"www"];
}

- (NSString *)appVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return ([infoDictionary objectForKey:@"CFBundleShortVersionString"]
            ? : [infoDictionary objectForKey:(__bridge NSString *)kCFBundleVersionKey]);
}
@end
