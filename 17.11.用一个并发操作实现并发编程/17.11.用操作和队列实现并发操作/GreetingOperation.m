//
//  GreetingOperation.m
//  17.11.用操作和队列实现并发操作
//
//  Created by 陈泽嘉 on 16/3/2.
//  Copyright © 2016年 dibadalu. All rights reserved.
//
#warning 要正确实现自定义并发操作类，必须添加许多额外的功能。因此，只有在不将操作对象添加到操作队列中，并通过异步方式执行该操作对象的情况下，才应该这么做。


#import "GreetingOperation.h"

@implementation GreetingOperation
{
    BOOL finished;
    BOOL executing;
}

// 初始化实例变量
- (id)init{
    if (self = [super init]) {
        finished = NO;
        executing = NO;
    }
    return self;
}

// 重写start方法（将该方法更新为以异步方式执行操作，通常在新的线程中调用main方法来实现）
- (void)start{
    // 如果操作被取消了就返回结果
    if ([self isCancelled]) {
#warning 需要通过KVO通知改变实例变量的值
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }

    [self willChangeValueForKey:@"isExecuting"];
    // 创建新的线程执行main方法中的操作
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];

}
// 重写main方法（该方法应实现与操作相关联的任务）
- (void)main{
    @autoreleasepool {
        @try {
            NSLog(@"Hello, World!");
            // 模拟执行任务的过程
            [NSThread sleepForTimeInterval:3.0];
            NSLog(@"Goodbye, World!");
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            executing = NO;
            finished = YES; 
            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];

            
        }
        @catch (NSException *exception) {}
    }
}

#warning 需要配置和管理操作的执行环境：isConcurrent、isExecuting和isFinished（具备线程安全性）
- (BOOL)isConcurrent{
    return YES;
}

- (BOOL)isExecuting{
    return executing;
}

- (BOOL)isFinished{
    return finished;
}

@end
