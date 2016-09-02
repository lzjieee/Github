//
//  Item.m
//  MeituanApp
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)itemWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
