//
//  Message.h
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/22.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MessageTypeMe = 0, //自己
    MessageTypeOther = 1 //其他人
} MessageType;

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageType type;
//记录是否显示时间label
@property (nonatomic, assign) BOOL hideTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;


@end
