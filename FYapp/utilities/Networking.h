//
//  Networking.h
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class Response;

#define Networking [AFHTTPSessionManager shareManager]

@interface AFHTTPSessionManager (NetworkingExt)

+ (AFHTTPSessionManager *)shareManager;

- (NSURLSessionDataTask *)get:(NSString *)pathString
                   parameters:(NSDictionary *)parameters
                      success:(void(^)(NSURLSessionDataTask *task, Response *respon))success
                      failure:(void(^)(NSURLSessionDataTask *task, Response *respon))failure;

- (NSURLSessionDataTask *)post:(NSString *)pathString
                    parameters:(NSDictionary *)parameters
                       success:(void(^)(NSURLSessionDataTask *task, Response *respon))success
                       failure:(void(^)(NSURLSessionDataTask *task, Response *respon))failure;

- (NSURLSessionUploadTask *)upload:(NSString *)pathString
                        parameters:(NSDictionary *)parameters
                      constructing:(void (^)(id <AFMultipartFormData> formData))constructing
                          progress:(void(^)(NSProgress *uploadprogress))progress
                           success:(void(^)(NSURLSessionUploadTask *task, Response *respon))success
                           failure:(void(^)(NSURLSessionUploadTask *task, Response *respon))failure;

- (NSURLSessionDownloadTask *)download:(NSString *)pathString
                            parameters:(NSDictionary *)parameters
                           destination:(NSURL *(^)(NSURL *targetPath, NSURLResponse *response))destination
                              progress:(void(^)(NSProgress *uploadprogress))progress
                               success:(void(^)(NSURLSessionDownloadTask *task, Response *respon))success
                               failure:(void(^)(NSURLSessionDownloadTask *task, Response *respon))failure;
@end

#pragma mark - Response

typedef NS_ENUM(NSInteger, ResponseCode) {
    ResponseCodeSuccess = 0,
    ResponseCodeFailure = 1,
    ResponseCodeLoginConflict = 100001//是用来限制账号，不允许多设备登录的
};

@interface Response : NSObject

@property (nonatomic, readonly) ResponseCode code;
@property (nonatomic, readonly) BOOL isSuccess;

@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSTimeInterval timeInterval;
@property (nonatomic, readonly) NSDictionary *data;

+ (instancetype)responseWithObject:(id)responseObject;
+ (instancetype)successResponseWithData:(NSDictionary *)data;
+ (instancetype)failureResponseWithMessage:(NSString *)message;

@end

@interface MutableResponse : Response

@property (nonatomic, readwrite) ResponseCode code;

@property (nonatomic, readwrite) NSString *message;
@property (nonatomic, readwrite) NSTimeInterval timeInterval;
@property (nonatomic, readwrite) NSDictionary *data;

@end

#pragma mark - Response
@interface Request : NSObject

@end
