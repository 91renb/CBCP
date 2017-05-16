//
//  CBHttpManager.h
//  CBCP
//
//  Created by LC on 2017/5/13.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

//HTTP请求类别
typedef NS_ENUM(NSInteger,HttpRequestType) {
    HttpRequestGet,
    HttpRequestPost,
    HttpRequestPut,
    HttpRequestDelete,
};

typedef void(^SuccessBlock)(NSURLSessionDataTask * task, id responseObject);

typedef void(^FailureBlock)(NSURLSessionDataTask * task, NSError * error);

typedef void(^DownLoadProgressBlock)(NSProgress * downloadProgress);

typedef void(^UpLoadProgressBlock)(NSProgress * uploadProgress);

typedef void(^NetWork)(BOOL netWork);

@interface CBHttpManager : NSObject

/**
 单例
 
 @return 实例对象
 */
+ (CBHttpManager *)shareManager;

/**
 HTTP请求（GET,POST,PUT,DELETE）

 @param url               请求的地址---需要填写完整的url
 @param params            请求预留参数---视具体情况而定，可移除
 @param HttpRequestType   请求的方式
 @param success           请求成功的回调
 @param failure           请求失败的回调
 @param netWork           有无网络
 */
- (void)requestWithPath:(NSString *)url
            paramenters:(NSDictionary *)params
        HttpRequestType:(HttpRequestType)HttpRequestType
                success:(SuccessBlock)success
                failure:(FailureBlock)failure
                netWork:(NetWork)netWork;

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
                     netWork:(NetWork)netWork;

/**
 多张上传图片
 
 @param path               上传的地址---需要填写完整的url
 @param paramters          上传图片预留参数---视具体情况而定，可移除
 @param imageArray         上传的图片数组
 @param width              图片要被压缩到的宽度
 @param upLoadProgress     进度
 @param success            请求成功的回调
 @param failure            请求失败的回调
 @param netWork            有无网络
 */
- (void)upLoadImageArrayWithPath:(NSString *)path
                   withParamters:(NSDictionary *)paramters
                  withImageArray:(NSArray *)imageArray
                 withtargetWidth:(CGFloat )width
                    withProgress:(UpLoadProgressBlock)upLoadProgress
                         success:(SuccessBlock)success
                         failure:(FailureBlock)failure
                         netWork:(NetWork)netWork;

/**
 单张上传图片
 
 @param path              上传的地址---需要填写完整的url
 @param paramters         上传图片预留参数---视具体情况而定，可移除
 @param image             上传的图片
 @param width             图片要被压缩到的宽度
 @param upLoadProgress    进度
 @param success           请求成功的回调
 @param failure           请求失败的回调
 @param netWork           有无网络
 */
- (void)upLoadImageWithPath:(NSString *)path
              withParamters:(NSDictionary *)paramters
                  withImage:(UIImage *)image
            withtargetWidth:(CGFloat )width
               withProgress:(UpLoadProgressBlock)upLoadProgress
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure
                    netWork:(NetWork)netWork;

/**
 上传视频
 
 @param path               上传的地址--需要填写完整的url
 @param videoPath          上传的视频--本地沙盒的路径
 @param paramters          上传视频预留参数--根据具体需求而定，可以出
 @param upLoadProgress     进度
 @param success            请求成功的回调
 @param failure            请求失败的回调
 @param netWork            有无网络
 */
- (void)upLoadVideoWithPath:(NSString *)path
              withVideoPath:(NSString *)videoPath
              withParamters:(NSDictionary *)paramters
               withProgress:(UpLoadProgressBlock)upLoadProgress
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure
                    netWork:(NetWork)netWork;

/**
 取消网络请求
 */
- (void)cancelNetWork;
@end
