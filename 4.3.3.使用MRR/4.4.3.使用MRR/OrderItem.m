//
//  OrderItem.m
//  4.4.3.使用MRR
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

- (id)initWithName:(NSString *)itemName{
    if (self = [super init]) {
        NSLog(@"Initializing OrderItem object");
        name = itemName;
        // 由于OrderItme对象不再创建输入参数，实例变量就不再拥有该对象的所有权。
        // 但是，为了避免这个对象因其他操作而被无意中释放，应向变量name发送一条retain消息，从而获取该对象的所有权。
        [name retain];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"Deallocating OrderItem object");
    [name release];
    [super dealloc];
}

@end
