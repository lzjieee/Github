//
//  MessageFrame.m
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/22.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "MessageFrame.h"
#import <UIKit/UIKit.h>
#import "Message.h"
#import "NSString+LJNSStringExt.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message
{
    _message = message;
    
    CGFloat margin = 5;
    
    //获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //计算每个子控件的frame和行高
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 15;
    if(!message.hideTime)
    {
        //如果需要显示时间label，那么再计算frame
        _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + margin;
    CGFloat iconX = message.type == MessageTypeOther ? margin : screenW - margin - iconW;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //先计算正文的大小（思路：为字符串写一个分类，增加一个计算字符串长度的方法）
    
    CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:textFont];
    CGFloat textW = textSize.width + 40;
    CGFloat textH = textSize.height + 30;
    CGFloat textY = iconY;
    CGFloat textX = message.type == MessageTypeOther ? CGRectGetMaxX(_iconFrame) : (screenW - margin - iconW - textW);
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    //计算行高
    CGFloat maxY = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight = maxY + margin;
}

@end
