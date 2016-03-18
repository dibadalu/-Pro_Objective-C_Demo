//
//  OrderItem.h
//  4.4.3.使用MRR
//
//  Created by 陈泽嘉 on 16/1/31.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject
{
@public NSString *name;
}

- (id)initWithName:(NSString *)itemName;

@end
