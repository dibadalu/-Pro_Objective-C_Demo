//
//  main.m
//  6.5.使用ARC桥接转换（ARC Toll Free Bridging）
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // NS2CF
        NSString *greeting = [[NSString alloc] initWithFormat:@"%@", @"Hello, World!"];
        // 如果使用__bridge转换标记，有潜在的悬挂（悬垂）指针。使用__bridge_retained可以从ARC接管该对象，从而避免使ARC向该对象发送release消息。此刻，必须手动管理这个对象的生命周期
        CFStringRef cstr = (__bridge_retained CFStringRef)(greeting);
        printf("String length = %ld \n", CFStringGetLength(cstr));
        // 手动释放CFStringRef对象
        CFRelease(cstr);
        
    }
    return 0;
}

void testCF2NS()
{
    CFStringRef cstr = CFStringCreateWithCString(NULL, "Hello, World!", kCFStringEncodingASCII);
    // 如果使用__bridge转换标记，将出现内存泄露。使用__bridge_transfer可以避免使用手动方式管理该对象，而将该对象的所有权交给ARC，ARC会自动管理这个对象的生命周期
    NSArray *data = [NSArray arrayWithObject:(__bridge_transfer NSString *)cstr];
    NSLog(@"Array size = %ld", [data count]);
}
