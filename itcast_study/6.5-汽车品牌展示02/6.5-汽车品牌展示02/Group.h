//
//  Group.h
//  6.5-汽车品牌展示02
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *cars;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end
