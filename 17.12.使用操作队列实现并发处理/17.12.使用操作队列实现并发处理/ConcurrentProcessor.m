//
//  ConcurrentOperation.m
//  17.12.使用操作队列实现并发处理
//
//  Created by 陈泽嘉 on 16/3/3.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "ConcurrentProcessor.h"

@implementation ConcurrentProcessor
{
    NSInteger *computeResult;
}

- (id)initWithData:(NSInteger *)result computations:(NSUInteger)computations{
    if (self = [super init]) {
        _computations = computations;
        computeResult = result;
    }
    return self;
}

/**
 *  计数逻辑只会更加指定的计算次数（computations）增加计算结果。
 *  与并发操作不同，这里的线程执行状态（即isFinished和isExecuting属性）没有更新。这是由“操作队列”自动执行的。
 *  “异步机制”不是必需的。这是因为操作间的依赖性是可以声明的。这不仅可以防止操作并发访问共享数据，还能同步操作的执行次序。
 */
- (void)main{
    @autoreleasepool {
        @try {
            
            if (![self isCancelled]) {
                NSLog(@"Performing %ld computations", self.computations);
                [NSThread sleepForTimeInterval:1.0];
                // 执行计数操作
                for (int ii = 0; ii < self.computations; ii++) {
                    *computeResult = *computeResult + 1;
                }
            }
            
        }
        @catch (NSException *exception) {}
    }
}
@end
