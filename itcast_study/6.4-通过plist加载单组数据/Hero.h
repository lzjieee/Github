//
//  Hero.h
//  6.4-通过plist加载单组数据
//
//  Created by J_jie on 16/7/14.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)heroWithDict:(NSDictionary *)dict;

@end
