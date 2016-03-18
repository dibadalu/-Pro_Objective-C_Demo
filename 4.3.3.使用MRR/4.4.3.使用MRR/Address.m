//
//  Address.m
//  4.4.3.使用MRR
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "Address.h"

@implementation Address

- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"Initialzing Address object");
    }
    return self;
}

- (void)dealloc{
    NSLog(@"Deallocating Address object");
    [super dealloc];
}

@end
