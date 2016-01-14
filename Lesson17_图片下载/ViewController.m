//
//  ViewController.m
//  Lesson17_图片下载
//
//  Created by 屠赫宸 on 15/12/11.
//  Copyright © 2015年 屠赫宸. All rights reserved.
//

#import "ViewController.h"
#import "TTImageDownloader.h"

#import "UIImageView+WebCache.h"

@interface ViewController ()<TTImagaeDownDeoegate>
/**
 *  图图
 */
@property (weak, nonatomic) IBOutlet UIImageView *tutu;
@property(strong,nonatomic)UIActivityIndicatorView *activityIV;
@end

@implementation ViewController
#define tu @"https://upload.wikimedia.org/wikipedia/commons/7/7f/Williams_River-27527.jpg"
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tutu addSubview:self.activityIV];
    [self.activityIV startAnimating];
    //设置状态栏的活动只是其是否显示
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    //1.创建URL对象
    NSURL *url=[[NSURL alloc]initWithString:tu];
//    //2.创建会话单例
//    NSURLSession *session=[NSURLSession sharedSession];
//    //3.创建数据任务(内存)
//    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        UIImage *image=[UIImage imageWithData:data];
//        //在主线程中进行UI处理
//        [self performSelectorOnMainThread:@selector(showTu:) withObject:image waitUntilDone:YES];
//        
//       // 使用GCD的方式来在主线程中添加任务 (Block内部的代码在主线程中执行)
//        //dispatch_async(dispatch_get_main_queue(), ^{
//        
//        //});
//        
//    }];
//    //4.启动任务
//    [dataTask resume];
    
    
    [self.tutu sd_setImageWithURL:url];
    
//    
   /* //下载图片
    //1.创建URL
    NSURL *url=[[NSURL alloc]initWithString:tu];
    //2.创建网络会话
    NSURLSession *session=[NSURLSession sharedSession];
    //3.创建下载任务
    NSURLSessionDownloadTask *downloadTask=[session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //根据下载后放到本地的文件路径来创建
        NSData *data=[NSData dataWithContentsOfURL:location];
        //根据Data对象来获取图片对象
        UIImage *image=[UIImage imageWithData:data];
        //刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tutu.image=image;
        });
        NSLog(@"路径:%@",location);
    }];
    [downloadTask resume];*/
    //调用封装协议方法
    //[TTImageDownloader downloadImageWithImageURLString:tu delegate:self];
    //调用封装block方法
//    [TTImageDownloader downloadImageWithImageURLString:tu block:^(UIImage * _Nonnull image) {
//        self.tutu.image=image;
//    }];
}
-(void)imageDownloaderDidfinishedloadedImage:(UIImage *)image{
    self.tutu.image=image;
}

-(void)showTu:(UIImage *)image{
    
    self.tutu.image=image;
    //停止ActivityIndicator动画并移除视图
    [self.activityIV stopAnimating];
    [self.activityIV removeFromSuperview];
    //让活动栏菊花消失
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIV=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIV.color=[UIColor redColor];
    self.activityIV.center=self.tutu.center;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
