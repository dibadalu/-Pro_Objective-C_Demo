//
//  ConcurrentProcessor.m
//  17.9.使用线程实现并发处理
//
//  Created by 陈泽嘉 on 16/3/2.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "ConcurrentProcessor.h"

@interface ConcurrentProcessor()
@property (readwrite) NSInteger computeResult; // 启用写入操作

@end

@implementation ConcurrentProcessor
{// 用于线程管理和同步的私有实例变量
    NSString *computeID; // @synchronize指令锁定的唯一对象
    NSUInteger computeTasks; // 并行计算任务的计数
    NSLock *computeLock; // 锁对象
}

- (id)init{
    if (self = [super init]) {
        _isFinished = NO;
        _computeResult = 0;
        computeID = @"1";
        computeTasks = 0;
        computeLock = [NSLock new];
    }
    return self;
}

- (void)computeTask:(id)data{
    NSAssert(([data isKindOfClass:[NSNumber class]]), @"Not an NSNumber instance");
    NSUInteger computations = [data unsignedIntegerValue];
    @autoreleasepool {
        @try {
            // 1.获取锁并增加活动任务的计数
            if ([[NSThread currentThread] isCancelled]) {
                return;
            }
#warning 必须使用@synchronized指令控制对computeTasks变量的访问，从而只允许每次只有一个线程更新其内容
            @synchronized(computeID) {
                computeTasks++;
            }
            
            // 2.获取锁并执行关键代码部分中的计算操作
            [computeLock lock]; // 加锁
            if ([[NSThread currentThread] isCancelled]) {
                [computeLock unlock];
                return;
            }
            NSLog(@"Performing computations");
            // 执行计算操作
            for (int ii = 0; ii < computations; ii++) { // computations：所执行计算的次数
                self.computeResult = self.computeResult + 1;
            }
            [computeLock unlock]; // 解锁
            
            // 3.模拟额外的处理时间（在关键部分之外）
            [NSThread sleepForTimeInterval:1.0];
            
            // 4.减少活动任务数，如果数量为0，则更新标志位
            @synchronized(computeID) {
                computeTasks--;
                if (!computeTasks) { // computeTasks为0
                    self.isFinished = YES; 
                }
            }
            
        }
        @catch (NSException *exception) {}
    }
}

@end
