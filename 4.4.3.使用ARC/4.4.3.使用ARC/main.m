//
//  main.m
//  4.4.3.使用ARC
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderEntry.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建手动释放的OrderEntry对象
        NSString *a1 = @"A1";
        NSString *orderId = [[NSString alloc] initWithString:a1];
        OrderEntry *entry = [[OrderEntry alloc] initWithId:orderId];
        // 通过a1将orderId变量设置为nil，以验证ARC保留了该对象
        a1 = nil;
        
        // 查看orderId变量是否有值
        NSLog(@"New order, ID = %@, item = %@", entry->orderId, entry->orderItem->name);
      
        // 将entry变量设置为nil，ARC会自动释放OrderEntry对象，同时会释放OrderEntry对象的子（类）对象
        entry = nil;
      
        NSLog(@"----------------------------------");
        
        // 创建自动释放的OrderEntry对象（@autoreleasepool块结束时释放OrderEntry对象）
        OrderEntry *autoEntry = [[OrderEntry alloc] initWithId:@"A2"];
        NSLog(@"New order, ID = %@, item = %@", autoEntry->orderId, autoEntry->orderItem->name);

        
        /*
         小结：
         1.通过ARC内存管理方式创建OrderEntry对象。当这些对象不再被持有时，ARC会自动释放和废弃它们。
         2.用ARC管理了必需的依存对象，因而避免出现释放正在使用的对象的情况。
         */
        
    }
    return 0;
}
