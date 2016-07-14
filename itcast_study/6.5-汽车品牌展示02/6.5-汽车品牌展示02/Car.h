//
//  Car.h
//  6.5-汽车品牌展示02
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)carWithDict:(NSDictionary *)dict;

@end
