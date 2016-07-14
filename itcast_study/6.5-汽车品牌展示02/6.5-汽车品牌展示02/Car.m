//
//  Car.m
//  6.5-汽车品牌展示02
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "Car.h"

@implementation Car

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
