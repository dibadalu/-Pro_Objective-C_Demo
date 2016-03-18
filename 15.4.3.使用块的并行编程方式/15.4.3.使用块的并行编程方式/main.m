//
//  main.m
//  15.4.3.使用块的并行编程方式
//
//  Created by 陈泽嘉 on 16/2/6.
//  Copyright © 2016年 dibadalu. All rights reserved.
//  使用块进行并行编程。

#import <Foundation/Foundation.h>

// 请求url
#define BaiduURL @"https://www.baidu.com/index.html"
#define BingURL @"http://cn.bing.com//index.html"

// 对“块”起个别名吧（DownloadURL）
typedef void (^DownloadURL)(void);

/**
 *  发送网络请求，获取数据
 *
 *  @param url 请求url
 *
 *  @return 块常量表达式（用于执行任务）
 */
DownloadURL getDownloadURLBlock(NSString *url){
    NSString *urlString = url;
    return ^{
        /// 创建请求
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSError *error;
        NSDate *startTime = [NSDate date];
        // 以同步方式发送请求，获取数据
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        
        if (data == nil) {
            NSLog(@"Error loading request %@", [error localizedDescription]);
        }else{
            NSDate *endTime = [NSDate date];
            NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];
            NSLog(@"Time taken to download %@ = %f seconds", urlString, timeInterval);
        }
    };
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建任务请求
        dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        // 创建任务分组
        // 用于对任务进行编组、为执行异步操作对任务进行排队、等待已排队的任务组
        dispatch_group_t group = dispatch_group_create();
        
        // 记录当前时间，作为开始时间
        NSDate *startTime = [NSDate date];
        
        // 创建并分派异步任务
        dispatch_group_async(group, queue1, getDownloadURLBlock(BaiduURL));
        dispatch_group_async(group, queue2, getDownloadURLBlock(BingURL));
        
        // 用于主线程等待，
        // 直到任务分组中的所有任务执行完成为止
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        // 记录当前时间，作为结束时间
        NSDate *endTime = [NSDate date];
        
        // 计算执行所有任务所用的时间
        NSTimeInterval timeInterval = [endTime timeIntervalSinceDate:startTime];
        NSLog(@"Time taken to download URLs concurrently = %f seconds",  timeInterval);
        
    }
    return 0;
}
