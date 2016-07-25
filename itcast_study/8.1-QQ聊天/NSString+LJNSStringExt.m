//
//  NSString+LJNSStringExt.m
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/25.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "NSString+LJNSStringExt.h"

@implementation NSString (LJNSStringExt)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font
{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}

@end
