//
//  main.m
//  9.2.使用运行时系统API
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//  使用运行时系统API以动态方式创建一个类和一个类实例，并以动态方式向该实例添加一个变量

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

// 用于显示选择器的方法实现函数
static void display(id self, SEL _cmd){
    NSLog(@"Invoking method with selector %@ on %@ instance",
          NSStringFromSelector(_cmd),[self class]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        // 创建一个类对
        Class widgetClass = objc_allocateClassPair([NSObject class], "Wight", 0);
        
        // 向这个类添加一个方法
        const char *types = "v@:";//类型编码，具体看文档
        class_addMethod(widgetClass, @selector(display), (IMP)display, types);
        
        // 向这个类添加一个实例变量
        const char *height = "height";
        class_addIvar(widgetClass, height, sizeof(id), rint(log2(sizeof(id))), @encode(id));
        
        // 注册这个类
        objc_registerClassPair(widgetClass);
        
        // 创建一个widget实例并设置实例变量的值
        id widget = [[widgetClass alloc] init];
        id value = [NSNumber numberWithInt:15];
        [widget setValue:value forKey:[NSString stringWithUTF8String:height]];
        NSLog(@"Widget instance height = %@",
              [widget valueForKey:[NSString stringWithUTF8String:height]]);
        
        // 向widget实例发送一条消息
        objc_msgSend(widget, NSSelectorFromString(@"display"));
        
        // 以动态方式向widget实例添加一个变量（关联对象）
#warning 关联对象是指通过关键字引用的附加到类实例中的对象
        NSNumber *width = [NSNumber numberWithInt:10];
        objc_setAssociatedObject(widget, @"width", width, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        // 获取该变量的值并显示它
        id result = objc_getAssociatedObject(widget, @"width");
        NSLog(@"Widget instance width = %@", result);
        
        
    }
    return 0;
}
