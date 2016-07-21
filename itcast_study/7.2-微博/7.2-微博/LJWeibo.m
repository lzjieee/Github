//
//  LJWeibo.m
//  7.2-微博
//
//  Created by J_jie on 16/7/20.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "LJWeibo.h"

@implementation LJWeibo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)WeiboWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
