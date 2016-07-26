//
//  NotificationSender.h
//  8.2-通知的发布与监听
//
//  Created by J_jie on 16/7/26.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

// 通知的发布者
@interface NotificationSender : NSObject

// 通知的发布者的名称
@property (nonatomic, copy) NSString *name;

@end
