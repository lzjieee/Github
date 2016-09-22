//
//  ViewController.h
//  MeituanApp
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

/**
 代理思路：
 因为这里ViewController想刷新cell的pageControl，但是他做不到，所以想到找代理。
 发现可以TopMenuCell，
 所以TopMenuCell成为ViewController的代理对象
 具体实现：
 1.ViewController定义代理customPageControlDelegate，
 定义代理方法refreshPageControl（ViewController把(那个对象的代理)自己传过去）
 2.ViewController类中增加一个代理属性@property (nonatomic, weak) id<customPageControlDelegate> delegate;
 3.在需要调用代理方法的地方调用代理方法
 //首先判断代理对象是否实现了代理方法
 if([self.delegate respondsToSelector:@selector(refreshPageControl:)])
 {
 //调用代理方法
 [self.delegate refreshPageControl:self];
 }
 
 4.TopMenuCell中遵守customPageControlDelegate协议，实现代理方法customPageControlDelegate
 5.在创建TopMenuCell的时候设置代理对象cell.delegate = self;

 */

#import <UIKit/UIKit.h>

@class ViewController;
@protocol  CustomPageControlDelegate <NSObject>

- (void)refreshPageControl:(ViewController *) viewController;

@end

@interface ViewController : UIViewController

@property (nonatomic, weak) id<CustomPageControlDelegate> delegate;

@end

