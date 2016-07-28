//
//  Friend.m
//  9.2-好友列表
//
//  Created by J_jie on 16/7/27.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
