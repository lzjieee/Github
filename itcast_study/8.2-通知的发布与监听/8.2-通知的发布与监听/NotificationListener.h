//
//  NotificationListener.h
//  8.2-通知的发布与监听
//
//  Created by J_jie on 16/7/26.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

// 消息的监听者
@interface NotificationListener : NSObject

// 消息的监听者的名称
@property (nonatomic, copy) NSString *name;

- (void)m1:(NSNotification *)noteInfo;

@end
