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
