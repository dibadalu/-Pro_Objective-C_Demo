//
//  OrderEntry.m
//  4.4.3.使用ARC
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "OrderEntry.h"
#import "Address.h"
#import "OrderItem.h"

@implementation OrderEntry

- (id)initWithId:(NSString *)oid name:(NSString *)order{
    if (self = [super init]) {
        NSLog(@"Initialzing OrderEntry object");
//        orderId = oid;
//        orderItem = [[OrderItem alloc] initWithName:@"Doodle"];
        _orderId = oid;
        _orderItem = [[OrderItem alloc] initWithName:order];
        shippingAddress = [[Address alloc] init];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"Deallocating OrderEntry object with ID %@", self.orderId);
}

@end
