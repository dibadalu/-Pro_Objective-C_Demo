//
//  main.m
//  17.12.使用操作队列实现并发处理
//
//  Created by 陈泽嘉 on 16/3/2.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConcurrentProcessor.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        NSInteger result = 0;
        // 创建操作对象
        ConcurrentProcessor *processor1 = [[ConcurrentProcessor alloc] initWithData:&result computations:5];
        ConcurrentProcessor *processor2 = [[ConcurrentProcessor alloc] initWithData:&result computations:10];
        ConcurrentProcessor *processor3 = [[ConcurrentProcessor alloc] initWithData:&result computations:20];
        NSArray *operations = @[processor1,processor2,processor3];
        
        // 添加操作间的依赖
        [processor2 addDependency:processor1];
        [processor3 addDependency:processor2];
        
        // 将操作对象添加到操作队列中执行（会以异步方式执行这些操作）
        [queue addOperations:operations waitUntilFinished:NO];
        
        // 等待，当完成所有操作时显示结果
        [queue waitUntilAllOperationsAreFinished];
        NSLog(@"Computation result = %ld", result);
        
    }
    return 0;
}
