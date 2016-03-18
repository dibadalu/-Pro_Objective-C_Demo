//
//  main.m
//  15.4.2.使用块加载URL
//
//  Created by 陈泽嘉 on 16/2/6.
//  Copyright © 2016年 dibadalu. All rights reserved.
//  

#import <Foundation/Foundation.h>

#define IndexURL @"https://www.baidu.com/index.html"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 获取当前的Runloop
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        BOOL __block downloadComplete = NO;
        
        
        // 创建请求
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:IndexURL]];
        // 发送异步请求
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            if (data == nil) { // 接受不到响应数据
                NSLog(@"Error loading request %@",[connectionError localizedDescription]);
            }else{
                NSLog(@"\n\tDownloaded %lu bytes from quest %@", [data length], [request URL]);
            }
            downloadComplete = YES;
        }];
        
        // 一直循环直到完成加载资源的操作完成为止
        while (!downloadComplete && [loop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]){
            NSLog(@"循环中");
        }
        
        
    }
    return 0;
}
