//
//  MessageFrame.h
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/22.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#define textFont [UIFont systemFontOfSize:12]

@class Message;
@interface MessageFrame : NSObject

@property (nonatomic, strong) Message *message;

//以下的控件赋值操作都是内部的（message的set方法计算好），所以不希望外部赋值，加上readonly
//时间label的frame
@property (nonatomic, assign, readonly) CGRect timeFrame;
//头像的frame
@property (nonatomic, assign, readonly) CGRect iconFrame;
//正文的frame
@property (nonatomic, assign, readonly) CGRect textFrame;

//cell的行高
@property (nonatomic, assign, readonly) CGFloat rowHeight;


@end
