//
//  TTImageDownloader.m
//  Lesson17_图片下载
//
//  Created by 屠赫宸 on 15/12/11.
//  Copyright © 2015年 屠赫宸. All rights reserved.
//

#import "TTImageDownloader.h"

@implementation TTImageDownloader
+(void)downloadImageWithImageURLString:(nonnull NSString *)urlString delegate:(nonnull id<TTImagaeDownDeoegate>)delegate{
    NSURLSessionDownloadTask *downloadTask=[[NSURLSession sharedSession]downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //获取图片
        UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        //必须保证代理对象不为空(存在)而且代理对象实现代理方法的前提下 才传递数据给外界
        if (delegate &&[delegate respondsToSelector:@selector(imageDownloaderDidfinishedloadedImage:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate imageDownloaderDidfinishedloadedImage:image];
            });
        }
    }];
    [downloadTask resume];
}

+(void)downloadImageWithImageURLString:(nonnull NSString *)urlString block:(TTDownloaderBlock __nonnull)block{
    NSString *string=[urlString substringToIndex:4];
    if ([string isEqualToString:@"http"]) {
        NSURLSessionDownloadTask *downloadTask=[[NSURLSession sharedSession]downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //图片下载完成后传递给外界
                block(image);
            });
        }];
        [downloadTask resume];
    }else{
        //抛出异常
        @throw [NSException exceptionWithName:@"TTImageDownloader Error" reason:@"你瞎啊  你家网址这屌样?!" userInfo:nil];
    }
    
}


@end
