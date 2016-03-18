//
//  main.m
//  8.1.2.1.使用运行时系统库API创建类
//
//  Created by 陈泽嘉 on 16/1/17.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

// 函数，返回简单的问候语
NSString *greeting(id self, SEL _cmd){
    return [NSString stringWithFormat: @"Hello, World!"];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        // 以动态方式创建一个类
        Class dynaClass = objc_allocateClassPair([NSObject class], "DynaClass", 0);
        
        // 以动态方式添加一个方法，使用已有的方法（description）获取特征  注意：方法签名相同
        Method description = class_getInstanceMethod([NSObject class], @selector(description));
        const char *types = method_getTypeEncoding(description);
        class_addMethod(dynaClass, @selector(greeting), (IMP)greeting, types);
        
        // 注册这个类
        objc_registerClassPair(dynaClass);
        
        // 使用该类创建一个实例并向其发送一条消息
        id dynaObj = [[dynaClass alloc] init];
        NSLog(@"%@", objc_msgSend(dynaObj, NSSelectorFromString(@"greeting")));
        
    }
    return 0;
}
