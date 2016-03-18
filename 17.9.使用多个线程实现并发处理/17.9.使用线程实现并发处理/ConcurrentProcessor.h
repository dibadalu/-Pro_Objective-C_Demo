//
//  ConcurrentProcessor.h
//  17.9.使用线程实现并发处理
//
//  Created by 陈泽嘉 on 16/3/2.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConcurrentProcessor : NSObject

/** 标识完成计算操作的信号 */
@property (readwrite) BOOL isFinished;
/** 计算操作所取得的结果 */
@property (readonly) NSInteger computeResult;

/**
 *  该方法执行计算操作（由独立线程执行）
 *
 *  @param data 执行计算操作的次数
 */
- (void)computeTask:(id)data;

@end
