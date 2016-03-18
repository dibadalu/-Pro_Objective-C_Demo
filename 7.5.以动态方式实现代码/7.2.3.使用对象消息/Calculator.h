//
//  Calculator.h
//  7.2.3.使用对象消息
//
//  Created by 陈泽嘉 on 16/1/16.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject


- (NSNumber *)sumAddend1:(NSNumber *)adder1 addend2:(NSNumber *)adder2;
// 第2个参数使用了空参数
- (NSNumber *)sumAddend1:(NSNumber *)adder1 :(NSNumber *)adder2;


@end
