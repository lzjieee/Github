//
//  Item.h
//  MeituanApp
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *desc;
@property(nonatomic, copy)NSString *price;
@property(nonatomic, copy)NSString *rackRate;
@property(nonatomic, copy)NSString *buyCount;
@property(nonatomic, copy)NSString *distance;
@property(nonatomic, copy)NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
