//
//  main.m
//  15.4.1.使用块为数组排序
//
//  Created by 陈泽嘉 on 16/2/6.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>

#define ArrayElements 10

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        // 创建可变数组
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:ArrayElements];
        // 向数组放入10个随机数值（范围为0~99）
        for (int elem = 0; elem < ArrayElements ; elem++) {
            unsigned int value = arc4random() % 100;
            [array addObject:[NSNumber numberWithUnsignedInt:value]];
        }
        // 打印未排序的数组
        NSLog(@"%@", array);
        
        // 通过"块常量表达式"对数组的元素进行排序，升序
        [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }else if ([obj1 integerValue] < [obj2 integerValue]){
                return (NSComparisonResult)NSOrderedAscending;
            }else{
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        
        // 打印已排序的数组
        NSLog(@"%@", array);
        
        /*
         小结：
         使用块常量表达式对数组进行排序
         */
        
    }
    return 0;
}
