//
//  BasicGreeter.m
//  DanaLoader
//
//  Created by 陈泽嘉 on 16/1/22.
//  Copyright © 2016年 dibadalu. All rights reserved.
//

#import "BasicGreeter.h"

@implementation BasicGreeter

- (NSString *)greeting:(NSString *)salutation{
    return [NSString stringWithFormat:@"%@, World!", salutation];
}

@end
