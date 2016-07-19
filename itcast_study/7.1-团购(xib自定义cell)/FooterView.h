//
//  FooterView.h
//  7.1-团购(xib自定义cell)
//
//  Created by J_jie on 16/7/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FooterView;
@protocol FooterViewDelegate <NSObject>

/**
 写代理方法的规范：
 1.方法名都以xxxxx控价+“方法名”
 2.方法第一个返回的参数是控件本身
 */

//写这个声明的时候，因为FooterView还没定义，所以报错。解决方法是要在开头@class
@required
- (void)footViewUpdateData:(FooterView *)footView;

@end


@interface FooterView : UIView

@property (nonatomic, weak) id<FooterViewDelegate> delegate;

+ (instancetype)footerView;

@end
