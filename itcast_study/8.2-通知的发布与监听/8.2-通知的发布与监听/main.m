//
//  main.m
//  8.2-通知的发布与监听
//
//  Created by J_jie on 16/7/26.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationListener.h"
#import "NotificationSender.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 1.创建通知发布者
        NotificationSender *sender1 = [[NotificationSender alloc] init];
        
        // 2.创建一个通知的监听者
        NotificationListener *listener1 = [[NotificationListener alloc] init];
        
        // 3.先获取 NSNotificationCenter 对象 （通知的工具）
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        
        // 4.监听一个消息 (要先监听，后发布)...
        //   参数1（监听对象）、参数2（监听方法）、参数3（被监听的通知名字）、参数4（发布通知的对象）
        //   也就是 让listener1的m1方法监听sender1的“通知名称1”通知.
        // 注意*** 如果没有指定参数3(或者参数3为nil)，但是指定了参数4，那么表示凡是sender1对象发布的所有通知m1方法会监听到，并执行****
        // 注意*** 如果指定参数3(就是指定要监听某个通知)，但是没有指定参数4，那么表示无论是哪个对象发布的与给定的通知名称相同的通知m1方法会监听到，并执行****
        // 注意*** 如果参数3、参数4都是nil，那么表示所有对象发布的所有通知m1方法会监听到，并执行****
        [notificationCenter addObserver:listener1 selector:@selector(m1:) name:@"通知名称1" object:sender1];
        
        // 5.让sender1发布一个消息
        // 5.1 通过 NSNotificationCenter 发布一个通知
        //**notificationCenter postNotification 有3个方法，本质都一样，内部会封装成一个NSNotification对象
        // 参数1（通知名字）、参数2（通知发布者）、参数3（通知的具体内容）
        [notificationCenter postNotificationName:@"通知名称1"
                                          object:sender1 userInfo:@{@"title" : @"两会开始了" ,
                                                                    @"content" : @"成龙的头发少了"
                                                                                        }];
        
        // 6.移除通知 listener的dealloc中处理
        
        
    }
    return 0;
}
