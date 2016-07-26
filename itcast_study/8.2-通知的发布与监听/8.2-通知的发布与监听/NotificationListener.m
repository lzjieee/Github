//
//  NotificationListener.m
//  8.2-通知的发布与监听
//
//  Created by J_jie on 16/7/26.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "NotificationListener.h"

@implementation NotificationListener

// 编写一个方法，用于监听时执行
- (void)m1:(NSNotification *)noteInfo
{
    /**
     noteInfo.name(监听的通知名称)
     noteInfo.object(通知发布对象)
     noteInfo.userInfo(一个字典，是通知的具体内容)
    */
    NSLog(@"duang....m1被执行了");
    NSLog(@"%@", noteInfo);
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
