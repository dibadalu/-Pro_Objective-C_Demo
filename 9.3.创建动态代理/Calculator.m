//
//  Calculator.m
//  7.2.3.使用对象消息
//
//  Created by 陈泽嘉 on 16/1/16.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <objc/runtime.h>
#import "Calculator.h"


@implementation Calculator

/**
 *  动态方法
 *
 *  @param sel <#sel description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSString *method = NSStringFromSelector(sel);
    if ([method hasPrefix:@"absoluteValue"]) {
        // class_addMethod()是一个运行时系统API，使用它能以动态方式将函数作为实例方法添加到类中
        class_addMethod([self class], sel, (IMP)absoluteValue, "@@:@");
        NSLog(@"Dynamically added instance method %@ to class %@",method,[self class]);
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

/**
 *  absoluteValue()函数，被添加为实例方法
 *
 *  @param self  设置接收对象
 *  @param _cmd  设置方法的选择器
 *  @param value <#value description#>
 *
 *  @return id类型
 */
id absoluteValue(id self, SEL _cmd, id value){
    
    NSInteger intVal = [value integerValue];
    if (intVal < 0) {
        return [NSNumber numberWithInteger:(intVal * -1)];
    }
    return value;
}

- (NSNumber *)sumAddend1:(NSNumber *)adder1 addend2:(NSNumber *)adder2{
    
    // _cmd:隐式参数，NSStringFromSelector会返回被调用方法的选择器文本字符串
    NSLog(@"Invorking method on %@ object with selector %@",[self class],NSStringFromSelector(_cmd));
    return [NSNumber numberWithInteger:([adder1 integerValue] +
                                        [adder2 integerValue])];
    
}

- (NSNumber *)sumAddend1:(NSNumber *)adder1 :(NSNumber *)adder2{
    
    NSLog(@"Invorking method on %@ object with selector %@",[self class],NSStringFromSelector(_cmd));
    return [NSNumber numberWithInteger:([adder1 integerValue] +
                                        [adder2 integerValue])];
}



@end
