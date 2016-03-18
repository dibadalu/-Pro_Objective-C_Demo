//
//  AuditingInvoker.m
//  9.3.创建动态代理
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "AuditingInvoker.h"

@implementation AuditingInvoker

- (void)preInvoke:(NSInvocation *)inv withTarget:(id)target{
    NSLog(@"Creating audit log before sending message with selector %@ to %@ object", NSStringFromSelector([inv selector]),[target className]);
}

- (void)postInvoke:(NSInvocation *)inv withTarget:(id)target{
    NSLog(@"Creating audit log after sending message with selector %@ to %@ object", NSStringFromSelector([inv selector]),[target className]);

}


@end
