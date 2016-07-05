//
//  Question.m
//  4-1疯狂猜图
//
//  Created by J_jie on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Question.h"

@implementation Question

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.answer = dict[@"answer"];
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
        self.options = dict[@"options"];
    }
    return self;
}

+ (instancetype)questionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
