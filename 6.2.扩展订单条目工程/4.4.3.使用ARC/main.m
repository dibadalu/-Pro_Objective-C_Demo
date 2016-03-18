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
        
        // 创建一个OrderEntry对象
        OrderEntry *entry1 = [[OrderEntry alloc] initWithId:@"A-1" name:@"2 Hot dogs"];
        NSLog(@"Order 1, ID = %@, item = %@", entry1.orderId, entry1.orderItem.name);
      
        
        // 创建另一个OrderEntry对象
        OrderEntry *entry2 = [[OrderEntry alloc] initWithId:@"A-2" name:@"1 cheesburger"];
        NSLog(@"Order 2, ID = %@, item = %@", entry2.orderId, entry2.orderItem.name);
        
        // 将entry1和entry2装进数组entries中
        // entries持有它们所持有的对象的强引用
        NSArray *entries = [[NSArray alloc] initWithObjects:entry1,entry2, nil];
        NSLog(@"Number of order entries = %li", [entries count]);
        
        NSLog(@"-------------------------------------");
        
        // 将持有OrderEntry对象的entry2变量设置为nil，ARC会向该对象发送一条release消息
        // entry2变量失去OrderEntry对象的强引用（持有），该对象被释放，但是entries数组仍然持有该对象，所以该对象不会被废弃
        NSLog(@"Setting entry2 varible to nil");
        entry2 = nil;
        
        NSLog(@"-------------------------------------");

        
        // 将持有OrderEntry对象集的entries数组设置为nil，ARC会向包含其中的每一个OrderEntry对象发送一条release消息
        // entries数组失去对包含其中的每一个OrderEntry对象的强引用（持有），OrderEntry对象都被释放，其中，entry2变量原先所持有的OrderEntry对象此时被废弃，而entry1变量仍然持有其OrderEntry对象
        NSLog(@"Setting entries collection varible to nil");
        entries = nil;
        
        NSLog(@"-------------------------------------");
        
        // 将持有OrderEntry对象的entry1变量设置为nil，ARC会向该对象发送一条release消息
        // entry1变量失去对OrderEntry对象的强引用，该对象被释放被废弃
        NSLog(@"Setting entry1 varible to nil");
        entry1 = nil;
     
        NSLog(@"-------------------------------------");

        NSLog(@"Leaving autoreleasepool block");
    }
    return 0;
}
