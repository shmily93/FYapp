//
//  LoginCenter.h
//  FYapp
//
//  Created by fanyi on 2017/9/14.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface LoginCenter : NSObject

@property (nonatomic, readonly) NSString *authToken;
@property (nonatomic, readonly) User *userl;


@end
