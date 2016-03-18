//
//  main.m
//  4.4.3.使用MRR
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderEntry.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建手动释放的OrderEntry对象
        NSString *orderId = [[NSString alloc] initWithString:@"A1"];
        OrderEntry *entry = [[OrderEntry alloc] initWithId:orderId];
        
        // orderId变量失去对持有对象的强引用，对象被释放。
        // 但是，entry变量仍然持有对该对象的强引用，所以该对象不会被废弃
        [orderId release]; // 如果没有释放orderId，将发生内存泄露
        
        NSLog(@"New order, ID = %@, item = %@", entry->orderId, entry->orderItem->name);
        
        // 手动释放entry变量对OrderEntry对象的强引用，OrderEntry对象被释放被废弃。
        // 同时，OrderEntry对象的子（类）对象也被释放被废弃。
        [entry release];
        
        NSLog(@"----------------------------------");
        
        // 创建自动释放的OrderEntry对象（@autoreleasepool块结束时释放OrderEntry对象）
        OrderEntry *autoEntry = [[[OrderEntry alloc] initWithId:@"A2"] autorelease];
        NSLog(@"New order, ID = %@, item = %@", autoEntry->orderId, autoEntry->orderItem->name);

        
    }
    return 0;
}
