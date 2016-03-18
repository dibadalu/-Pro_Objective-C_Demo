//
//  CustomGreeter.m
//  CustomgGreeter
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "CustomGreeter.h"

@implementation CustomGreeter

- (NSString *)greeting:(NSString *)salutation{
    return [NSString stringWithFormat:@"%@, Universe!", salutation];
}

@end
