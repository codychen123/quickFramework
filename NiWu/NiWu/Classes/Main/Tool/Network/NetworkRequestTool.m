/*!
 @header      NetworkRequestTool.h
 @abstract    网络请求工具类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */

#import "NetworkRequestTool.h"
#import "NSData+YYAdd.h"
#import "DefaultResponseModel.h"
#import "PYAlertView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface NetworkRequestTool ()

@end

@implementation NetworkRequestTool

#pragma mark - /******************** 单例初始化 *********************/
+ (NetworkRequestTool *)sharedInstance
{
    static NetworkRequestTool * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}

+ (AFHTTPSessionManager *)sharedManager
{
    static AFHTTPSessionManager * sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedManager == nil) {
            sharedManager = [AFHTTPSessionManager manager];
            sharedManager.requestSerializer.timeoutInterval = 30.0f;//设置超时时间
            sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            //返回格式
            sharedManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
            
            sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"image/jpeg",@"image/png",
                                                                       @"application/octet-stream",@"text/json",nil];
            sharedManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        }
    });
    return sharedManager;
}

#pragma mark - /******************** 构造请求 *********************/

#pragma mark - 外层GET请求
- (void)getSeriviceWithURL:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void (^)(NSString *returnMessage,DefaultResponseModel *responseObject))success
                   failure:(void (^)(NSString *returnMessage,  id responseObject))failure
              errorClourse:(void (^)(NSString *errorMessage, NSError *error))errorClourse
{
    [self getSeriviceWithURL:url params:params success:^(id responseObject) {
        
        DefaultResponseModel *model = [DefaultResponseModel mj_objectWithKeyValues:responseObject];
        if (model.code == ReturnCodeSuccess) {
            PYLogDebug(@"\n✅Success URL:%@\nData:%@",url,model.data);
            success(model.message , model);
        }else{
            if (model.code == ReturnCodeuserNotPermitted) {
                [self loginIfTokenInvaild];
                return;
            }
            PYLogDebug(@"❌URL:%@,Error:%@,Code:%d",url,model.message,model.code);
            failure(model.message ,model);
        }
    } failure:^(NSString *errorMessage, NSError *error) {
        errorClourse(errorMessage,error);
    }];
}


- (void)getSeriviceWithURL:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSString *errorMessage, NSError *error))failure
{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:params];
    AFHTTPSessionManager *manager = [NetworkRequestTool sharedManager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PYLog(@"\n-------------- URL --------------\n%@\n-------------- JSON Begin-------------- \n%@\n-------------- JSON End --------------" , url,[responseObject mj_JSONString]);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络异常" , error);
        PYLogDebug(@"❌URL:%@,Error:%@",url,error);
    }];
}

- (void)loginIfTokenInvaild {
    [MBProgressHUD hideHUD];
    // clean local user data if login status invaild
//    [[GlobalDataModel sharedInstance] userLogout];
//    LoginViewController *vc = [[LoginViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [KEY_WINDOW.rootViewController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 外层POST请求
- (void)postSeriviceWithURL:(NSString *)url
                     params:(NSDictionary *)params
                    success:(void (^)(NSString *returnMessage,DefaultResponseModel* responseObject))success
                    failure:(void (^)(NSString *returnMessage,  id responseObject))failure
               errorClourse:(void (^)(NSString *errorMessage, NSError *error))errorClourse
{
    
    [self postSeriviceWithURL:url params:params success:^(id responseObject) {
        DefaultResponseModel *model = [DefaultResponseModel mj_objectWithKeyValues:responseObject];
        
        if (model.code == ReturnCodeSuccess) {
            PYLogDebug(@"\n✅Success URL:%@\nData:%@",url,model.data);
            success(model.message,model);
        }else{
            
            if (model.code == ReturnCodeuserNotPermitted) {
                [MBProgressHUD hideLoadingView];
                [self loginIfTokenInvaild];
                return;
            }
            PYLogDebug(@"\n❌URL:%@,Error:%@,Code:%d",url,model.message,model.code);
            failure(model.message ,model);
        }
    } failure:^(NSString *errorMessage, NSError *error) {
        errorClourse(errorMessage,error);
    }];
}


- (void)postSeriviceWithURL:(NSString *)url
                     params:(NSDictionary *)params
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSString *errorMessage, NSError *error))failure
{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:params];
    AFHTTPSessionManager *manager = [NetworkRequestTool sharedManager];
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PYLog(@"\n-------------- URL --------------\n%@\n-------------- JSON Begin-------------- \n%@\n-------------- JSON End --------------" , url,[responseObject mj_JSONString]);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络异常" , error);
        PYLogDebug(@"\n❌URL:%@,Error:%@",url,error);
    }];
}


- (void)postSeriviceWithURL:(NSString *)url params:(NSDictionary *)params
  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))constructingBodyWithBlock
                    success:(void (^)(NSString *returnMessage,DefaultResponseModel* responseObject))success
                    failure:(void (^)(NSString *, id))failure
               errorClourse:(void (^)(NSString *, NSError *))errorClourse
{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:params];
    AFHTTPSessionManager *manager = [NetworkRequestTool sharedManager];
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        constructingBodyWithBlock(formData);
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DefaultResponseModel *model = [DefaultResponseModel mj_objectWithKeyValues:responseObject];
        if (model.code == ReturnCodeSuccess) {
            PYLogDebug(@"\n✅Success URL:%@\nData:%@",url,model.data);
            success(model.message,model);
        }else{
            if (model.code == ReturnCodeuserNotPermitted) {
                [self loginIfTokenInvaild];
                return;
            }
            PYLogDebug(@"\n❌URL:%@,Error:%@,Code:%d",url,model.message,model.code);
            failure(model.message ,model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorClourse(@"网络异常",error);
        PYLogDebug(@"\n❌URL:%@,Error:%@",url,error);
    }];
    
}

- (void)postImgWithPath:(NSString *)urlStr data:(NSArray *)picArray andParams:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure withHub:(BOOL)isHub
{
    AFHTTPSessionManager *manager = [NetworkRequestTool sharedManager];
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        for (NSInteger i = 0; i < picArray.count; i ++) {
            UIImage *image= picArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *name =   [NSString stringWithFormat:@"uploadFile%ld",(long)i] ;
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        if (isHub) {
            [[PYAlertView sharedInstance] showloadingAnimationWithProgressMessage:@"正在上传.." progress:uploadProgress.fractionCompleted];
        }
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        PYLogDebug(@"%@", responseObject);
        success(responseObject);
        if (isHub) {
            [[PYAlertView sharedInstance] dismiss];
        }
        if ([responseObject[@"error_code"] integerValue] == 0){
            [[PYAlertView sharedInstance] showMessage:@"上传成功" customView:@"OK"];
        }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        // 上传失败
        failure(error);
        [[PYAlertView sharedInstance] showMessage:@"上传失败" customView:@"no"];
    }];
}


@end
