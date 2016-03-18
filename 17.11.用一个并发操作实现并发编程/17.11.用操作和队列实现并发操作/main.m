//
//  main.m
//  17.11.用操作和队列实现并发操作
//
//  Created by 陈泽嘉 on 16/3/2.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GreetingOperation.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        // 创建一个GreetingOperation对象
        GreetingOperation *operation = [GreetingOperation new];
        [operation start]; // 调用start方法执行操作
        while (![operation isFinished]); // 直到所有操作执行完为止
        
    }
    return 0;
}
