//
//  ConcurrentOperation.h
//  17.12.使用操作队列实现并发处理
//
//  Created by 陈泽嘉 on 16/3/3.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConcurrentProcessor : NSOperation

@property (readonly) NSUInteger computations;

/**
 *  初始化方法
 *
 *  @param result       保存操作的计算结果
 *  @param computations 执行操作的次数
 *
 *  @return 操作对象
 */
- (id)initWithData:(NSInteger *)result computations:(NSUInteger)computations;

@end
