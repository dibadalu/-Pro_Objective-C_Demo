//
//  OrderItem.m
//  4.4.3.使用ARC
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "OrderItem.h"

@implementation OrderItem

- (id)initWithName:(NSString *)itemName{
    if (self = [super init]) {
//        name = itemName;
        _name = itemName;
        NSLog(@"Initializing OrderItem object %@", _name);
    }
    return self;
}

- (void)dealloc{
    NSLog(@"Deallocating OrderItem object %@", self.name);
}

@end
