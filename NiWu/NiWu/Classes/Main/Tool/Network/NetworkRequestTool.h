/*!
 @header      NetworkRequestTool.h
 @abstract    网络请求工具类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkRequestTool : NSObject
@property (copy, nonatomic) NSString *requestMethod; //请求的方法名
@property (strong, nonatomic) NSMutableDictionary * queryDictionary;//原始query
+ (NetworkRequestTool *)sharedInstance;
+ (AFHTTPSessionManager *)sharedManager;


/**
 GET请求(格式规范的默认接口)

 @param url URL地址
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 @param errorClourse 异常回调
 */
- (void)getSeriviceWithURL:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void (^)(NSString *returnMessage,DefaultResponseModel *responseObject))success
                   failure:(void (^)(NSString *returnMessage,id responseObject))failure
              errorClourse:(void (^)(NSString *errorMessage, NSError *error))errorClourse;


/**
 GET请求(格式不规范的外部接口)

 @param url URL地址
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getSeriviceWithURL:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSString *errorMessage, NSError *error))failure;

/**
 POST请求(格式规范的默认接口)
 
 @param url URL地址
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 @param errorClourse 异常回调
 */
- (void)postSeriviceWithURL:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void (^)(NSString *returnMessage, DefaultResponseModel *responseObject))success
                   failure:(void (^)(NSString *returnMessage, id responseObject))failure
              errorClourse:(void (^)(NSString *errorMessage, NSError *error))errorClourse;


/**
 POST请求(格式不规范的外部接口)
 
 @param url URL地址
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)postSeriviceWithURL:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSString *errorMessage, NSError *error))failure;




/**
 POST请求(上传图片)

 @param url URL地址
 @param params 参数
 @param constructingBodyWithBlock 构造体回调
 @param success 成功回调
 @param failure 失败回调
 @param errorClourse 异常回到
 */
- (void)postSeriviceWithURL:(NSString *)url
                     params:(NSDictionary *)params
constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))constructingBodyWithBlock
                    success:(void (^)(NSString *returnMessage,DefaultResponseModel* responseObject))success
                    failure:(void (^)(NSString *returnMessage,id responseObject))failure
               errorClourse:(void (^)(NSString *errorMessage, NSError *error))errorClourse;


/**
 上传多张图片

 @param urlStr URL地址
 @param picArray 图片数组
 @param params 参数
 @param success 成功回调
 @param failure 失败回调
 @param isHub 是否正在上传
 */
- (void)postImgWithPath:(NSString *)urlStr
                   data:(NSArray *)picArray
              andParams:(NSDictionary *)params
                success:(void(^)(id responseObject))success
                failure:(void (^)(NSError *error))failure
                withHub:(BOOL)isHub;

@end
