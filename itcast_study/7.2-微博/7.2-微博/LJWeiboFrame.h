//
//  LJWeiboFrame.h
//  7.2-微博
//
//  Created by J_jie on 16/7/21.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class LJWeibo;
@interface LJWeiboFrame : NSObject

@property (nonatomic, strong) LJWeibo *weibo;

//各个控件的frame
@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect nameFrame;
@property (nonatomic, assign, readonly) CGRect vipFrame;
@property (nonatomic, assign, readonly) CGRect textFrame;
@property (nonatomic, assign, readonly) CGRect picFrame;

//行高
@property (nonatomic, assign, readonly) CGFloat rowHeight;

@end
