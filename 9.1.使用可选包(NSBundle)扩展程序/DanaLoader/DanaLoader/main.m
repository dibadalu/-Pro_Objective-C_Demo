//
//  main.m
//  DanaLoader
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicGreeter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // greeter变量被声明为id类型并遵守Greeter协议
        id<Greeter> greeter = [[BasicGreeter alloc] init];
        NSLog(@"%@", [greeter greeting:@"Hello"]);
        
        /*---------------------------------------*/
        
        // 在（通过输入参数获得的）指定路径创建一个包
        NSString *bundlePath;
        if (argc != 2) {
            // 没有获得包路径，退出
            NSLog(@"Please provide a path for the bundle");
        }else{
            // 获取包路径
            bundlePath = [NSString stringWithUTF8String:argv[1]];
            // 创建一个NSBundle对象
            NSBundle *greeterBundle = [NSBundle bundleWithPath:bundlePath];
            if (greeterBundle == nil) {
                NSLog(@"Bundle not found at path");
            }else{
                // 以动态方式加载包
                NSError *error;
                BOOL isLoaded = [greeterBundle loadAndReturnError:&error];
                if (!isLoaded) {
                    NSLog(@"Error = %@", [error localizedDescription]);
                }else{
                    // 加载包，创建greeterClass类
                    Class greeterClass = [greeterBundle classNamed:@"CustomGreeter"];
                    // 创建一个greeterClass对象
#warning 由于greeter变量被声明为id类型并且遵守Greeter协议，所以所有遵守Greeter协议的Objective-C对象都能赋予到greeter
                    greeter = [[greeterClass alloc] init];
                    // 向greeterClass对象发送一条消息
                    NSLog(@"%@", [greeter greeting:@"Hello"]);
                }
                
                // 使用以动态方式加载的包后，卸载它
                // 先释放所有用包中的类创建的对象！
                greeter = nil;
                BOOL isUnloaded = [greeterBundle unload];
                if (!isUnloaded) {
                    NSLog(@"Cunldn't unload bundle");
                }
            }
        }
        
    }
    return 0;
}
