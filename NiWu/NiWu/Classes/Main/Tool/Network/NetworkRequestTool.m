/*!
 @header      NetworkRequestTool.h
 @abstract    网络请求工具类
 @author      Created by TeLong on 17/3/1
 @version     17/3/1
 Copyright © 2017年 peb. All rights reserved.
 */

#import "NetworkRequestTool.h"
#import "NSData+YYAdd.h"
#import "GTMBase64.h"
#import "DefaultResponseModel.h"
#import "LoginViewController.h"
#import "EncryptionTool.h"
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
             //打开加密
            #warning - 灰度环境的话,可以改成YES , 测试环境NO
            sharedInstance.useSecurity = YES;
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

//- (instancetype)initWithBaseURL:(NSURL *)url
//{
//    self = [super initWithBaseURL:(NSURL *)url];
//    if (self) {
//        _queryDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
//    }
//

//    return self;
//}

#pragma mark - /******************** 构造请求 *********************/


//- (AFSecurityPolicy *)customSecurityPolicy
//{
//    // /先导入证书
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"clientkey.cer" ofType:nil];//证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//
//    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
//
//    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//    // 如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
//    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
//    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = NO;
//
//    securityPolicy.pinnedCertificates = @[certData];
//
//    return securityPolicy;
//}


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
    if (self.needToken){
        parameter[@"token"] = [GlobalDataModel sharedInstance].memberInfo.token;
        parameter[@"pyId"] = [GlobalDataModel sharedInstance].memberInfo.pyId;
    }
    
    if (self.useSecurity) {
        NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timestamp = [nowDate timeIntervalSince1970] ;
        NSString *timeStr = [NSString stringWithFormat:@"%f", timestamp];
        parameter[@"timestamp"] = @([timeStr intValue]);
        parameter[@"sign"] = [EncryptionTool encryptionnWithParams:parameter appKey:kPuYinAppkey];
    }
    AFHTTPSessionManager *manager = [NetworkRequestTool sharedManager];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PYLog(@"\n-------------- URL --------------\n%@\n-------------- JSON Begin-------------- \n%@\n-------------- JSON End --------------" , url,[responseObject mj_JSONString]);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络异常" , error);
        PYLogDebug(@"❌URL:%@,Error:%@",url,error);
    }];
}

- (void)loginIfTokenInvaild{
    [MBProgressHUD hideHUD];
    // clean local user data if login status invaild
    [[GlobalDataModel sharedInstance] userLogout];
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [KEY_WINDOW.rootViewController presentViewController:nav animated:YES completion:nil];
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
    if (self.needToken){
        parameter[@"token"] = [GlobalDataModel sharedInstance].memberInfo.token;
        parameter[@"pyId"] = [GlobalDataModel sharedInstance].memberInfo.pyId;
    }
    if (self.useSecurity) {
        NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timestamp = [nowDate timeIntervalSince1970] ;
        NSString *timeStr = [NSString stringWithFormat:@"%f", timestamp];
        parameter[@"timestamp"] = @([timeStr intValue]);;
        parameter[@"sign"] = [EncryptionTool encryptionnWithParams:parameter appKey:kPuYinAppkey];
    }
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
    if (self.needToken){
        parameter[@"token"] = [GlobalDataModel sharedInstance].memberInfo.token;
        parameter[@"pyId"] = [GlobalDataModel sharedInstance].memberInfo.pyId;
    }
    if (self.useSecurity) {
        NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval timestamp = [nowDate timeIntervalSince1970] ;
        NSString *timeStr = [NSString stringWithFormat:@"%f", timestamp];
        parameter[@"timestamp"] = @([timeStr intValue]);
        parameter[@"sign"] = [EncryptionTool encryptionnWithParams:parameter appKey:kPuYinAppkey];
    }
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
