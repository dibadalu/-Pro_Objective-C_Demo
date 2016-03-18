//
//  main.m
//  7.2.3.使用对象消息
//
//  Created by 陈泽嘉 on 16/1/16.
//  Copyright © 2016年 dibadalu. All rights reserved.

/*
 警告：PerformSelector may cause a leak because its selector is unknown
 如果找不到与该选择器匹配的方法，那么方法就会抛出异常，因而可能导致内存泄露。
 解决方法：可以通过添加pragma指令取出警告
 */


#import <Foundation/Foundation.h>
#import "Calculator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建类的一个实例（对象）
        Calculator *calc = [Calculator new];
        NSNumber *addend1 = [NSNumber numberWithInteger:25];
        NSNumber *addend2 = [NSNumber numberWithInteger:10];
        NSNumber *addend3 = [NSNumber numberWithInteger:15];
        
// 禁用了诊断功能（所以不会发出警告），并保存和恢复编译器当前的诊断设置
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

        // 选择器使用@selector()指令，在编译时创建的
        SEL selector1 = @selector(sumAddend1:addend2:);
        id sum1 = [calc performSelector:selector1 withObject:addend1 withObject:addend2];
        NSLog(@"Sum of %@ + %@ = %@",addend1,addend2,sum1);
        
        // 选择器使用NSSelectorFromString()函数，在程序运行时创建的
        SEL selector2 = NSSelectorFromString(@"sumAddend1::");
        id sum2 = [calc performSelector:selector2 withObject:addend1 withObject:addend3];
        NSLog(@"Sum of %@ + %@ = %@",addend1,addend3,sum2);
        
#pragma clang diagnostic pop
        
    }
    return 0;
}
