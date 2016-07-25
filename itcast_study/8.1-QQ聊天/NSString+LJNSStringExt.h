//
//  NSString+LJNSStringExt.h
//  8.1-QQ聊天
//
//  Created by J_jie on 16/7/25.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LJNSStringExt)

//对象方法(XXXOfXXX)
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

//类方法 (XXXWithXXX)

+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;

@end
