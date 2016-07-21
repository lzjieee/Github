//
//  LJWeiboFrame.m
//  7.2-微博
//
//  Created by J_jie on 16/7/21.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "LJWeiboFrame.h"
#import "LJWeibo.h"
#import <UIKit/UIKit.h>

#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:14]

@implementation LJWeiboFrame

//重写weibo属性的set方法
- (void)setWeibo:(LJWeibo *)weibo
{
    _weibo = weibo;
    
    //计算各个控件的frame和cell的行高
    //统一间距
    CGFloat margin = 10;
    
    //1.头像
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    CGFloat iconY = margin;
    CGFloat iconX = margin;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //2.昵称
    NSString *nickName = weibo.name;
    //注意：计算字体大小，这里计算的字体大小必须和创建label控件时候指定的文字大小一样，算出来才准确
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + margin;
    //影响昵称label的高和宽的因素：字体大小、文字大小、高度取决于是否固定了宽度（是否限制了最大的宽高）
    //根据label中的文字内容，动态计算label的宽高
    //boundingRectWithSize:参数一，给label限定一个大小，这里不限定 ； attributes是指定一个字体
    CGSize nameSize = [self sizeWithText:nickName andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:nameFont];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    CGFloat nameY = iconY + (iconH - nameH) / 2;
    _nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //3.会员(创建子控件的时候已经设置了,这里只要设置是否显示这个控件就可以了)
    CGFloat vipW = 10;
    CGFloat vipH = 10;
    CGFloat vipX = CGRectGetMaxX(_nameFrame) + margin;
    CGFloat vipY = nameY;
    _vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    //4.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_iconFrame) + margin;
    CGSize textSize = [self sizeWithText:weibo.text andMaxSize:CGSizeMake(300, MAXFLOAT) andFont:textFont];
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    //5.配图
    CGFloat picX = iconX;
    CGFloat picY = CGRectGetMaxY(_textFrame) + margin;
    CGFloat picW = 100;
    CGFloat picH = 100;
    _picFrame = CGRectMake(picX, picY, picW, picH);
    
    
    //6.计算每行的高度
    CGFloat rowHight = 0;
    if(self.weibo.picture)
    {
        //如果有图
        rowHight = CGRectGetMaxY(_picFrame) + margin;
    }
    else
    {
        rowHight = CGRectGetMaxY(_textFrame) + margin;
    }

    _rowHeight = rowHight;
}

//根据给定的字符串、最大值的size。字体。来计算文字应该占用的大小
- (CGSize) sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    //注意：计算字体大小，这里计算的字体大小必须和创建label控件时候指定的文字大小一样，算出来才准确
    NSDictionary *attr = @{NSFontAttributeName: font};
    //影响昵称label的高和宽的因素：字体大小、文字大小、高度取决于是否固定了宽度（是否限制了最大的宽高）
    //根据label中的文字内容，动态计算label的宽高
    //boundingRectWithSize:参数一，给label限定一个大小，这里不限定 ； attributes是指定一个字体
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
