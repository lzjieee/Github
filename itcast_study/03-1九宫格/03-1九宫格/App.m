//
//  App.m
//  03-1九宫格
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "App.h"

@implementation App

-(instancetype)initWithDict:(NSDictionary*)dict
{
    if(self = [super init])
    {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+(instancetype)appWithDict:(NSDictionary*)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
