//
//  main.m
//  17.13.GCD
//
//  Created by 陈泽嘉 on 16/3/3.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>

// 给块起别名
typedef void (^ComputeTask)(void);

/**
 *  检索用于下载URL的语句块
 *
 *  @param result      计算操作的结果
 *  @param computation 计算操作的次数
 *
 *  @return <#return value description#>
 */
ComputeTask getComputeTask(NSInteger *result, NSUInteger computation){
    NSInteger *computeResult = result;
    NSUInteger computations = computation;
    return ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"Performing %ld computations", computations);
        // 执行计算操作
        for (int ii = 0; ii < computations; ii++) {
            *computeResult = *computeResult + 1;
        }
    };
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        NSInteger computeResult;
        
        // 创建"顺序"队列和分组
        dispatch_queue_t serialQueue = dispatch_queue_create("MyserialQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_group_t group = dispatch_group_create();
        
        // 向队列中添加任务，任务会以“异步”方式执行
        dispatch_group_async(group, serialQueue, getComputeTask(&computeResult, 5));
        dispatch_group_async(group, serialQueue, getComputeTask(&computeResult, 10));
        dispatch_group_async(group, serialQueue, getComputeTask(&computeResult, 20));
        
        // 等待，dispatch_group_wait被用于阻塞主线程，直到分组中的所有任务都完成。
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        NSLog(@"Computation result = %ld", computeResult);
        
        
    }
    return 0;
}
