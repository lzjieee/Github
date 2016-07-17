//
//  Goods.h
//  7.1-团购(xib自定义cell)
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

@property (nonatomic, copy) NSString *buyCount;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)goodsWithDict:(NSDictionary *)dict;

@end
