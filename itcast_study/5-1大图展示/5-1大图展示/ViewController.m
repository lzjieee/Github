//
//  ViewController.m
//  5-1大图展示
//
//  Created by J_jie on 16/7/8.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (IBAction)scrollBtnClicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //告诉uiscrollView，存在于uiscrollView里面内容的实际大小
    //设置uiscrollView的内容大小 = 图片框的大小(这个方式要在main.storyboard中将imgView的size改大)
    //self.scrollView.contentSize = self.imgView.frame.size;
    //将img的实际大小设置给scrollView
    self.scrollView.contentSize = self.imgView.image.size;
    //隐藏滚动指示器（就是指滚动到边界时，滑动条是否显示）
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
    
    //设置内容的内边距
    self.scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scrollBtnClicked:(id)sender
{
    //通过修改contentOffset来用代码自动滑动
    
    CGPoint point = self.scrollView.contentOffset;
    point.x += 150;
    point.y += 150;
    //直接修改contentOffset，实现滚动，没动画效果
    //self.scrollView.contentOffset = point;
    
    //通过block动画实现滚动(可控制动画时间)
//    [UIView animateWithDuration:1.0 animations:^{
//        self.scrollView.contentOffset = point;
//    }];
    
    //通过使用动画的方式来设置contentOffset
    [self.scrollView setContentOffset:point animated:YES];
}

@end
