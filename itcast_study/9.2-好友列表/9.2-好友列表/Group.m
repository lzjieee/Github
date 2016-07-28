//
//  Group.m
//  9.2-好友列表
//
//  Created by J_jie on 16/7/27.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "Group.h"
#import "Friend.h"

@implementation Group

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        //把self.friends由字典数组 => 模型数据
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict_sub in self.friends)
        {
            Friend *model = [Friend friendWithDict:dict_sub];
            [arrayModels addObject:model];
        }
        self.friends = arrayModels;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
