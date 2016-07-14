//
//  Group.m
//  6.5-汽车品牌展示02
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "Group.h"
#import "Car.h"

@implementation Group

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        /**
         模型嵌套：
            Group中包含一个nsstring 和 一个 array（模型嵌套）
            setValuesForKeysWithDictionary方法实际上是
            self.title = dict[@"tile"];
            self.cars = dict[@"cars"]; //这里cars本身也是一个array数组包含许多字典，这样赋值有问题（模型嵌套了）
         结论：
            对于这种，手动把字典转模型
         */
        
        //赋值title 和 cars属性，但是cars仍然是个array数组包含许多字典，不是model数组
        [self setValuesForKeysWithDictionary:dict];
        
        //创建一个用于保存model的数组
        NSMutableArray *arrayModel = [NSMutableArray array];
        //需要把字典转模型，得到模型数组
        for (NSDictionary *item_dict in dict[@"cars"])
        {
            Car *model = [Car carWithDict:item_dict];
            [arrayModel addObject:model];
        }
        self.cars = arrayModel;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
