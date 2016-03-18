//
//  main.m
//  9.3.创建动态代理
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AspectProxy.h"
#import "AuditingInvoker.h"
#import "Calculator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建Calculator对象
        id calculator = [[Calculator alloc] init];
        NSNumber *addend1 = [NSNumber numberWithInteger:-25];
        NSNumber *addend2 = [NSNumber numberWithInteger:10];
        NSNumber *addend3 = [NSNumber numberWithInteger:15];

        // 为该对象创建代理calculatorProxy
        // 设置代理中注册的选择器数组
        NSValue *selValue1 = [NSValue valueWithPointer:@selector(sumAddend1:addend2:)];
        NSArray *selValues = @[selValue1];
        // 创建AuditingInvoker
        AuditingInvoker *invoker = [[AuditingInvoker alloc] init];
        // 创建Calculator对象的代理calculatorProxy
        id calculatorProxy = [[AspectProxy alloc] initWithObject:calculator selectors:selValues andInvoker:invoker];
        
        // 使用指定的选择器向该代理发送消息
        [calculatorProxy sumAddend1:addend1 addend2:addend2];
        
        // 使用还未注册到代理中的其他选择器，向这个代理发送消息！
        [calculatorProxy sumAddend1:addend1 :addend3];
        
        // 为这个代理注册一个选择器并再次向其发送消息
        [calculatorProxy registerSelector:@selector(sumAddend1::)];
        [calculatorProxy sumAddend1:addend1 :addend3];

        /*
         观察output：
         1.调用Calculator对象的代理中的sumAddend1:addend2:方法，会使该代理调用
         AuditingInvoker对象中的preInvoker:方法、真正目标（Calculator对象）中的
         sumAddend1:addend2:方法，以及AuditingInvoker对象中的postInvoker:方法
         因为sumAddend1:addend2:方法是通过Calculator对象的代理注册的；
         2.调用Calculator对象代理中的sumAddend1::方法，因为该方法还未通过这个代理注册，所以程序仅会将调用该方法的消息转发给Calculator对象，而不会调用AuditorInvoker方法
         3.sumAddend1::通过这个代理进行了注册，然后程序再次调用它，在这次调用过程中，程序会调用AuditingInvoker对象中的AOP方法和真正目标（Calculator对象）中的
         sumAddend1::方法
         */
        
    }
    return 0;
}
