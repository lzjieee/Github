//
//  App.h
//  9.3-应用管理
//
//  Created by J_jie on 16/7/28.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject

@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *download;

//增加一个是否点击过的属性
@property (nonatomic, assign) BOOL isDownloaded;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)appWithDict:(NSDictionary *)dict;

@end
