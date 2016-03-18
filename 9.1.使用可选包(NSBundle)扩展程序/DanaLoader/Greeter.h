//
//  Greeter.h
//  DanaLoader
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//  Greeter协议

#import <Foundation/Foundation.h>

@protocol Greeter <NSObject>

- (NSString *)greeting:(NSString *)salutation;

@end
