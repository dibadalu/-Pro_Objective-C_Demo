//
//  main.m
//  8.2.2.执行对象内省
//
//  Created by 陈泽嘉 on 16/1/18.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>


// 测试类
@interface Greeter : NSObject
@property(readwrite,strong) NSString *salutation;
- (NSString *)greeting:(NSString *)recipient;
@end
@implementation Greeter
- (NSString *)greeting:(NSString *)recipient{
    // [self salutation] == 调用getter方法
    return [NSString stringWithFormat:@"%@, %@", [self salutation], recipient];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 创建Greeter实例
        Greeter *greeter = [Greeter new];
        [greeter setSalutation:@"Hello"];
        
        // 使用NSObject类的运行时方法执行对象内省
        if ([greeter respondsToSelector:@selector(greeting:)]&&
            [greeter conformsToProtocol:@protocol(NSObject)]) {
            // 执行运行时方法performSelector:withObject:向Greeter实例发送一条消息
            id result = [greeter performSelector:@selector(greeting:) withObject:@"Monster!"];
            NSLog(@"%@", result);
        }
        
    }
    return 0;
}


