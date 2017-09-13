//
//  Networking.m
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "Networking.h"
#import "AppConfig.h"
#import <M9Dev/M9Dev.h>

@implementation AFHTTPSessionManager (NetworkingExt)

+ (AFHTTPSessionManager *)shareManager {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[AppConfig shareInstance].baseURL
                                           sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return manager;
}

- (NSURLSessionDataTask *)get:(NSString *)pathString
                   parameters:(NSDictionary *)parameters
                      success:(void(^)(NSURLSessionDataTask *task, Response *respon))success
                      failure:(void(^)(NSURLSessionDataTask *task, Response *respon))failure {
    return [self makeRequest:^NSMutableURLRequest *(NSString *urlPath, NSDictionary *parameters, NSError *__autoreleasing *serializationError) {
        return [self.requestSerializer requestWithMethod:@"GET" URLString:pathString parameters:parameters error:serializationError];
    } makeTask:^__kindof NSURLSessionTask *(NSURLRequest *request, void (^completionHandler)(NSURLResponse *response, id responseObject, NSError *error)) {
        return [self dataTaskWithRequest:request completionHandler:completionHandler];
    } urlString:pathString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)post:(NSString *)pathString
                    parameters:(NSDictionary *)parameters
                       success:(void(^)(NSURLSessionDataTask *task, Response *respon))success
                       failure:(void(^)(NSURLSessionDataTask *task, Response *respon))failure {
    return [self makeRequest:^NSMutableURLRequest *(NSString *urlPath, NSDictionary *parameters, NSError *__autoreleasing *serializationError) {
        return [self.requestSerializer requestWithMethod:@"POST" URLString:pathString parameters:parameters error:serializationError];
    } makeTask:^__kindof NSURLSessionTask *(NSURLRequest *request, void (^completionHandler)(NSURLResponse *response, id responseObject, NSError *error)) {
        return [self dataTaskWithRequest:request completionHandler:completionHandler];
    } urlString:pathString parameters:parameters success:success failure:failure];
}

- (NSURLSessionUploadTask *)upload:(NSString *)pathString
                        parameters:(NSDictionary *)parameters
                      constructing:(void (^)(id <AFMultipartFormData> formData))constructing
                          progress:(void(^)(NSProgress *uploadprogress))progress
                           success:(void(^)(NSURLSessionUploadTask *task, Response *respon))success
                           failure:(void(^)(NSURLSessionUploadTask *task, Response *respon))failure {
    return [self makeRequest:^NSMutableURLRequest *(NSString *urlPath, NSDictionary *parameters, NSError *__autoreleasing *serializationError) {
        return [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:pathString parameters:parameters constructingBodyWithBlock:constructing error:serializationError];
    } makeTask:^__kindof NSURLSessionTask *(NSURLRequest *request, void (^completionHandler)(NSURLResponse *response, id responseObject, NSError *error)) {
        return [self uploadTaskWithStreamedRequest:request progress:progress completionHandler:completionHandler];
    } urlString:pathString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDownloadTask *)download:(NSString *)pathString
                            parameters:(NSDictionary *)parameters
                           destination:(NSURL *(^)(NSURL *targetPath, NSURLResponse *response))destination
                              progress:(void(^)(NSProgress *uploadprogress))progress
                               success:(void(^)(NSURLSessionDownloadTask *task, Response *respon))success
                               failure:(void(^)(NSURLSessionDownloadTask *task, Response *respon))failure {
    return [self makeRequest:^NSMutableURLRequest *(NSString *urlPath, NSDictionary *parameters, NSError *__autoreleasing *serializationError) {
        return [self.requestSerializer requestWithMethod:@"GET" URLString:pathString parameters:parameters error:serializationError];
    } makeTask:^__kindof NSURLSessionTask *(NSURLRequest *request, void (^completionHandler)(NSURLResponse *response, id responseObject, NSError *error)) {
        return [self downloadTaskWithRequest:request progress:progress destination:destination completionHandler:completionHandler];
    } urlString:pathString parameters:parameters success:success failure:failure];
}

#pragma mark - private
- (__kindof NSURLSessionTask *)makeRequest:(NSMutableURLRequest *(^)(NSString *urlPath, NSDictionary *parameters, NSError *__autoreleasing *serializationError))makeRequest
                                  makeTask:(__kindof NSURLSessionTask *(^)(NSURLRequest *request, void (^completionHandler)(NSURLResponse *response, id responseObject, NSError *error)))makeTask
                                 urlString:(NSString *)urlString
                                parameters:(NSDictionary *)parameters
                                   success:(void(^)(__kindof NSURLSessionTask *task, Response *respon))success
                                   failure:(void(^)(__kindof NSURLSessionTask *task, Response *respon))failure {
    NSError *serializationError = nil;
    NSMutableURLRequest *request = makeRequest(urlString, parameters, &serializationError);
    
    if(!request || serializationError) {
        if(failure) {
            dispatch_async(self.completionQueue ?:dispatch_get_main_queue(), ^{
                failure(nil, [Response failureResponseWithMessage:serializationError.localizedDescription]);
            });
            return nil;
        }
    }
    //设置UA
    NSString * const userAgentKey = @"User-Agent";
    NSString *userAgent = [request valueForHTTPHeaderField:userAgentKey] ?:@"--";
    NSString *appVersion = [AppConfig shareInstance].appVersion;
    userAgent = [userAgent stringByAppendingFormat:@"%@", appVersion];
    [request setValue:userAgentKey forHTTPHeaderField:userAgentKey];
    
    typeof(self) __weak __weak_self__ = self;
    __block __kindof NSURLSessionTask *task = makeTask(request, ^(NSURLResponse *response, id responseObject, NSError *error){
        typeof(__weak_self__) __strong self = __weak_self__;
        
        if(task.state == NSURLSessionTaskStateCanceling || error.code == NSURLErrorCancelled) {
            return ;
        }
        
        if(error) {
            if(failure) {
                dispatch_async(self.completionQueue ?:dispatch_get_main_queue(), ^{
                    failure(task, [Response failureResponseWithMessage:error.localizedDescription]);
                });
                return;
            }
        }
        
        Response *responses = [Response responseWithObject:responseObject];
        if(responses.isSuccess) {
            if(success) {
                if(success) {
                    dispatch_async(self.completionQueue ?:dispatch_get_main_queue(), ^{
                        success(task, responses);
                    });
                }
            }
        }
        else {
            if(responses.code == ResponseCodeLoginConflict) {//其他设备登录
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *message = responses.message ?:@"您的账号在其他设备登录";
                    NSLog(@"%@", message);
                });
            }
            else {
                if(failure) {
                    dispatch_async(self.completionQueue ?:dispatch_get_main_queue(), ^{
                        failure(task, [Response failureResponseWithMessage:error.localizedDescription]);
                    });
                    return;
                }
            }
        }
    });
    
    [task resume];
    
    return task;
}

@end

#pragma mark - Response
@interface Response ()

@property (nonatomic) id responseObject;

@end

@implementation Response

+ (instancetype)responseWithObject:(id)responseObject {
    Response *response = [Response new];
    response.responseObject = responseObject;
    return responseObject;
}

+ (instancetype)successResponseWithData:(NSDictionary *)data {
    MutableResponse *response = [MutableResponse new];
    response.code = ResponseCodeSuccess;
    response.message = nil;
    response.data = data;
    return response;
}

+ (instancetype)failureResponseWithMessage:(NSString *)message {
    MutableResponse *response = [MutableResponse new];
    response.code = ResponseCodeFailure;
    response.message = message;
    response.data = nil;
    return response;
}

- (ResponseCode)code {
    return [self.responseObject integerForKey:@"code" defaultValue:ResponseCodeFailure];
}

- (BOOL)isSuccess {
    return self.code == ResponseCodeSuccess;
}

- (NSString *)message {
    NSString *message = [self.responseObject stringForKey:@"msg" defaultValue:nil];
    return message.length ? message: nil;
}

- (NSDictionary *)data {
    NSDictionary *data = [self.responseObject dictionaryForKey:@"data"];
    return data.count ? data : nil;
}

- (NSTimeInterval)timeInterval {
    NSTimeInterval timestamp = [self.responseObject doubleForKey:@"ts"];
    if (timestamp <= NSTimeIntervalSince1970) {
        timestamp = [NSDate timeIntervalSinceReferenceDate] + NSTimeIntervalSince1970;
    }
    return timestamp;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> - %@",
            [self class], self, self.responseObject];
}

@end

@implementation MutableResponse

@synthesize code = _code, message = _message, timeInterval = _timeInterval, data = _data;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeInterval = [NSDate timeIntervalSinceReferenceDate] + NSTimeIntervalSince1970;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> - "
            "{\n"
            "    code: %td,\n"
            "    msg:  %@,\n"
            "    ts:   %.3f,\n"
            "    data: %@\n"
            "}",
            [self class], self, self.code, self.message, self.timeInterval, self.data];
}

@end
