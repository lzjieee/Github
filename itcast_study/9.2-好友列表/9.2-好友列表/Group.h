//
//  Group.h
//  9.2-好友列表
//
//  Created by J_jie on 16/7/27.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int online;
@property (nonatomic, strong) NSArray *friends;

// 表示这个组中的数据是否可见
@property (nonatomic, assign, getter=isVisible) BOOL visible;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;

@end
