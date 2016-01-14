//
//  TTImageDownloader.h
//  Lesson17_图片下载
//
//  Created by 屠赫宸 on 15/12/11.
//  Copyright © 2015年 屠赫宸. All rights reserved.
//
/**
 *  图片下载类
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TTImagaeDownDeoegate <NSObject>
/**
 *  图片下载完成以后代理对象执行的方法 用于携带下载完成的数据 传递给外界
 *
 *  @param image 下载完成的图片
 */
-(void)imageDownloaderDidfinishedloadedImage:(nonnull UIImage *)image;
@end
/**
 *  定义一个参数为image的Block 用于回调
 *
 *  @param image 传递的image参数
 */
typedef void(^TTDownloaderBlock)(UIImage *__nonnull image);


@interface TTImageDownloader : NSObject
/**
 *  使用代理下载图片的方法
 *
 *  @param urlString 图片网址字符串对象
 *  @param delegate  需要设置的代理对象
 */
+(void)downloadImageWithImageURLString:(nonnull NSString *)urlString delegate:(nonnull id<TTImagaeDownDeoegate>)delegate;
/**
 *  使用block下载图片的方法
 *
 *  @param urlString 图片网址字符串对象
 *  @param block     需要回调的block块
 */
+(void)downloadImageWithImageURLString:(nonnull NSString *)urlString block:(TTDownloaderBlock __nonnull)block;

@end
