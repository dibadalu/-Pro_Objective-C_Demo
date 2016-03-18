//
//  AspectProxy.h
//  9.3.创建动态代理
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//  AspectProxy代理类

#import <Foundation/Foundation.h>
#import "Invoker.h"

@interface AspectProxy : NSProxy

/** 通过NSProxy实例转发消息的真正对象 */
@property(strong) id proxyTarget;
/** 能够实现横切功能的类（遵守Invoker协议）的实例 */
@property(strong) id<Invoker> invoker;
/** 定义了哪些消息会调用横切功能 */
@property(readonly) NSMutableArray *selectors;

// AspectProxyl类实例的初始化方法
- (id)initWithObject:(id)object andInvoker:(id<Invoker>)invoker;
- (id)initWithObject:(id)object selectors:(NSArray *)selectors andInvoker:(id<Invoker>)invoker;
// 向当前的选择器列表中添加选择器
- (void)registerSelector:(SEL)selector;

@end
