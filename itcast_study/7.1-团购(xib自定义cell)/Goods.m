//
//  Goods.m
//  7.1-团购(xib自定义cell)
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


+ (instancetype)goodsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
