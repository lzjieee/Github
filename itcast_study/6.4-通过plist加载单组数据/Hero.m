//
//  Hero.m
//  6.4-通过plist加载单组数据
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "Hero.h"

@implementation Hero

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)heroWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
