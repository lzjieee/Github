//
//  ViewController.m
//  5.2-喜马拉雅app
//
//  Created by J_jie on 16/7/11.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgLast;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //找到最后一个控件imgLast的最大的y值作为contentsize的y值
    CGFloat maxH = CGRectGetMaxY(self.imgLast.frame);
    
    //设置srollview的contentsize(技巧:只要contentsize的x(y)比scrollview的x(y)的大，就能横向(竖向)滚动。这里不需要横向滚动所以设置x=0)
    self.scrollView.contentSize = CGSizeMake(0, maxH);
    //一开始设置默认滚动到下来一点
    self.scrollView.contentOffset = CGPointMake(0, -74);
    //设置内边距74（因为最上面有个导航栏）,下内边距也是54
    self.scrollView.contentInset = UIEdgeInsetsMake(74, 0, 54, 0);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
