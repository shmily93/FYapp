//
//  AppConfig.h
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface AppConfig : NSObject

@property (nonatomic) DeployType deployType;
@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, readonly) NSString *appVersion;

+(instancetype)shareInstance;

@end
