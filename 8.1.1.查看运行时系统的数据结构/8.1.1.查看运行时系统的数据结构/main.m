//
//  main.m
//  8.1.1.查看运行时系统的数据结构
//
//  Created by 陈泽嘉 on 16/1/17.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// 创建测试类
@interface TestClass1 : NSObject {
@public int myInt;// 全局变量
}
@end
@implementation TestClass1
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 为测试类创建几个实例并显示其数据
        TestClass1 *tc1A = [TestClass1 new];
        tc1A->myInt = 0xa5a5a5a5;
        TestClass1 *tc1B = [TestClass1 new];
        tc1B->myInt = 0xc3c3c3c3;
        // class_getInstanceSize()获取类实例的尺寸（以字节为单位）
        long tc1Size = class_getInstanceSize([TestClass1 class]);
        // 使用NSData类获取这些对象的数据
        NSData *tc1AData = [NSData dataWithBytes:(__bridge const void *)(tc1A) length:tc1Size];
        NSData *tc1BData = [NSData dataWithBytes:(__bridge const void *)(tc1B) length:tc1Size];
        // 将objc_object数据结构(其isa指针 + 该对象的实例变量的值)和类的内存地址打印到控制台
        NSLog(@"TestClass1 object tc1A contains %@", tc1AData);
        NSLog(@"TestClass1 object tc1B contains %@", tc1BData);
        NSLog(@"TestClass1 memory address = %p", [TestClass1 class]);
        
        /*
         小结：
         1.观察output，两个对象的isa指针相同，这是因为它们是同一个类的实例。
         2.isa指针的值指向该类的内存地址（ps：isa指针的地址是以翻转的字节顺序显示的）
         */
        
        /*--------------------------------------------------------------*/
        
        // objc_getClass()用于获取TestClass1类
        id testClz = objc_getClass("TestClass1");
        long tcSize = class_getInstanceSize([testClz class]);
        // 打印该类的数据，和其父类的内存地址
        NSData *tcData = [NSData dataWithBytes:(__bridge const void *)(testClz) length:tcSize];
        NSLog(@"TestClass1 class contains %@", tcData);
        NSLog(@"TestClass1 superclass memory address = %p", [TestClass1 superclass]);
        
        /*
         小结：
         观察output，TestClass1类含有的数据为一个isa指针和另外一个值，这个值实际上是指向该类的父类的“指针”
         */
    }
    return 0;
}
