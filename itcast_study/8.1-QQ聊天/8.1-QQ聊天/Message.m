//
//  Message.m
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/22.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
