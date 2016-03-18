//
//  main.m
//  17.9.使用线程实现并发处理
//
//  Created by 陈泽嘉 on 16/3/2.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConcurrentProcessor.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 创建一个ConcurrentProcessor对象
        ConcurrentProcessor *processor = [ConcurrentProcessor new];
        // 在后台执行3个独立的线程
        [processor performSelectorInBackground:@selector(computeTask:) withObject:[NSNumber numberWithUnsignedInteger:5]];
        [processor performSelectorInBackground:@selector(computeTask:) withObject:[NSNumber numberWithUnsignedInteger:10]];
        [processor performSelectorInBackground:@selector(computeTask:) withObject:[NSNumber numberWithUnsignedInteger:20]];
        while (!processor.isFinished); // 直到所有线程执行完才停止
        NSLog(@"Computations result = %ld",processor.computeResult);
        
        
    }
    return 0;
}
