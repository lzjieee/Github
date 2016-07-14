//
//  Group.m
//  6.3-汽车品牌展示
//
//  Created by J_jie on 16/7/13.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "Group.h"

@implementation Group

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        //方法1：
//        self.title = dict[@"title"];
//        self.desc = dict[@"desc"];
//        self.cars = dict[@"cars"];
        //方法2：（注意用这个方法必须保证self对象的属性和dict的健一模一样）KVC
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
