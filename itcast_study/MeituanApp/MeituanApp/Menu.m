//
//  Menu.m
//  MeituanApp
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Menu.h"

@implementation Menu

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)menuWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
