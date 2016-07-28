//
//  Friend.h
//  9.2-好友列表
//
//  Created by J_jie on 16/7/27.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign, getter = isVip) BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;

@end
