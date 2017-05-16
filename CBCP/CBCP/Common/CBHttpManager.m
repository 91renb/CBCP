//
//  CBHttpManager.m
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "CBHttpManager.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVAssetExportSession.h>

@interface CBHttpManager ()
@property (nonatomic, strong) AFHTTPSessionManager * manager;
@property (nonatomic, assign) BOOL isConnect;

@end

@implementation CBHttpManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"证书名"  ofType:@"cer"];
//        [self.manager setSecurityPolicy:[self securityPolicyWithPath:path]];
        
        //设置请求类型
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置响应类型
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/javascript",@"application/json",@"text/html",@"image/jpg",@"image/png",@"image/gif",@"application/octet-stream",@"application/xhtml+xml",@"*/*",@"application/xhtml+xml",@"image/webp",@"text/html", nil];

        self.manager.requestSerializer.timeoutInterval = 10;//默认是60秒
        
        //开启监听
        [self openNetMonitoring];
        
    }
    return self;
}

#pragma mark  -----监听网络-----
- (void)openNetMonitoring {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                static NSString * instance = nil;
                static dispatch_once_t onceToken;
                instance = [[NSString alloc] init];
                dispatch_once(&onceToken, ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:K_Notification_NetWork object:nil userInfo:nil];
                });
                
            }

                self.isConnect = YES;
                break;
            default:
                break;
        }
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    self.isConnect = YES;
}

#pragma mark  -----单例-----
/**
 单例
 
 @return 实例对象
 */
+ (CBHttpManager *)shareManager {
    
    static CBHttpManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
            paramenters:(NSDictionary *)params
        HttpRequestType:(HttpRequestType)HttpRequestType
                success:(SuccessBlock)success
                failure:(FailureBlock)failure
                netWork:(NetWork)netWork
{
    if (![self isConnectionAvailable]) {
        //无网
        if (netWork) {
            netWork(NO);
        }
        return;
    }

    switch (HttpRequestType) {
        case HttpRequestGet:
            self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [self.manager GET:url parameters:params progress:nil success:success failure:failure];
            break;
        case HttpRequestPost:
            self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [self.manager POST:url parameters:params progress:nil success:success failure:failure];
            break;
        case HttpRequestPut:
            [self.manager PUT:url parameters:params success:success failure:failure];
            break;
        case HttpRequestDelete:
            [self.manager DELETE:url parameters:params success:success failure:failure];
            break;
        default:
            break;
    }
}


#pragma mark  -----文件下载-----
/**
 文件下载
 
 @param url               下载地址
 @param downLoadProgress  下载进度
 @param success           下载成功
 @param failure           下载失败
 @param netWork           有无网络
 */
- (void)downLoadFileWithPath:(NSString *)url
                withProgress:(DownLoadProgressBlock)downLoadProgress
                     success:(void(^) (id filePath))success
                     failure:(void(^) (NSError *error))failure
                     netWork:(NetWork)netWork
{
    if (![self isConnectionAvailable]) {
        //无网
        if (netWork) {
            netWork(NO);
        }
        return;
    }
    
    NSURLSessionDownloadTask *downloadTask = [self.manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] progress:downLoadProgress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (filePath == nil) {
            if (failure) {
                failure(error);
            }
        }else{
            if (success) {
                success(filePath);
            }
        }
        
    }];
    //重新开始下载
    [downloadTask resume];
}


#pragma mark  -----单张上传图片-----
/**
 单张上传图片
 
 @param path           上传的地址---需要填写完整的url
 @param paramters      上传图片预留参数---视具体情况而定，可移除
 @param image          上传的图片
 @param width          图片要被压缩到的宽度
 @param upLoadProgress 进度
 @param success        请求成功的回调
 @param failure        请求失败的回调
 @param netWork        有无网络
 */
- (void)upLoadImageWithPath:(NSString *)path
              withParamters:(NSDictionary *)paramters
                  withImage:(UIImage *)image
            withtargetWidth:(CGFloat )width
               withProgress:(UpLoadProgressBlock)upLoadProgress
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure
                    netWork:(NetWork)netWork
{
    if (![self isConnectionAvailable]) {
        //无网
        if (netWork) {
            netWork(NO);
        }
        return;
    }

    [self.manager POST:path parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 压缩图片，指定宽度
        UIImage *  resizedImage =  [UIImage imageCompressed:image withdefineWidth:width];
        NSData * imgData = UIImageJPEGRepresentation(resizedImage, 0.5);
        // 拼接Data
        [formData appendPartWithFileData:imgData name:@"upload" fileName:@"Image.png" mimeType:@"image/jpeg"];
        
    } progress:upLoadProgress success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
    
}

/**
 多张上传图片
 
 @param path           上传的地址---需要填写完整的url
 @param paramters      上传图片预留参数---视具体情况而定，可移除
 @param imageArray     上传的图片数组
 @param width          图片要被压缩到的宽度
 @param upLoadProgress 进度
 @param success        请求成功的回调
 @param failure        请求失败的回调
 @param netWork        有无网络
 */
- (void)upLoadImageArrayWithPath:(NSString *)path
                   withParamters:(NSDictionary *)paramters
                  withImageArray:(NSArray *)imageArray
                 withtargetWidth:(CGFloat )width
                    withProgress:(UpLoadProgressBlock)upLoadProgress
                         success:(SuccessBlock)success
                         failure:(FailureBlock)failure
                         netWork:(NetWork)netWork
{
    if (![self isConnectionAvailable]) {
        //无网
        if (netWork) {
            netWork(NO);
        }
        return;
    }
    
    [self.manager POST:path parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageArray.count; i++)
        {
            UIImage *image = [imageArray objectAtIndex:i];
            //压缩图片，指定宽度
            UIImage *  resizedImage =  [UIImage imageCompressed:image withdefineWidth:width];
            NSData * imgData = UIImageJPEGRepresentation(resizedImage, 0.5);
            NSString *imageName = [NSString stringWithFormat:@"image%d_%d_%d.png",i,(int)resizedImage.size.width,(int)resizedImage.size.height];
            // 拼接Data
            [formData appendPartWithFileData:imgData name:@"upload" fileName:imageName mimeType:@"image/jpeg"];
        }
    } progress:upLoadProgress success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}

#pragma mark  -----上传视频-----
/**
 上传视频
 
 @param path            上传的地址--需要填写完整的url
 @param videoPath       上传的视频--本地沙盒的路径
 @param paramters       上传视频预留参数--根据具体需求而定，可以出
 @param upLoadProgress  进度
 @param success         请求成功的回调
 @param failure         请求失败的回调
 @param netWork         有无网络
 */
- (void)upLoadVideoWithPath:(NSString *)path
              withVideoPath:(NSString *)videoPath
              withParamters:(NSDictionary *)paramters
               withProgress:(UpLoadProgressBlock)upLoadProgress
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure
                    netWork:(NetWork)netWork
{
    if (![self isConnectionAvailable]) {
        //无网
        if (netWork) {
            netWork(NO);
        }
        return;
    }
    // 获取视频资源
    AVURLAsset * avUrlAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    // 视频压缩
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avUrlAsset presetName:AVAssetExportPreset640x480];
    // 获取上传的时间
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    // 转化后直接写入Library---caches
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        
        switch ([avAssetExport status]) {
                
            case AVAssetExportSessionStatusCompleted:
            {
                
                [self.manager POST:path parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    //获得沙盒中的视频内容
                    
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"videoName" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                    
                } progress:upLoadProgress success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(task,error);
                    }
                }];
                
                break;
            }
            default:
                break;
        }
    }];
}




#pragma mark  -----是否有网-----
/**
 是否有网
 
 @return 是否有网
 */
- (BOOL)isConnectionAvailable {
    
    return self.isConnect;
}


/**
 取消网络请求
 */
- (void)cancelNetWork
{
    [self.manager.operationQueue cancelAllOperations];

}

#pragma mark  -----读取证书-----
/**
 读取证书
 
 @param path     证书的路径
 @return         证书信息
 */
- (AFSecurityPolicy *)securityPolicyWithPath:(NSString *)path
{
    NSData *certData = [NSData dataWithContentsOfFile:path];
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}


@end
