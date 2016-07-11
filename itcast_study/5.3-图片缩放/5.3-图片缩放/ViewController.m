//
//  ViewController.m
//  5.3-图片缩放
//
//  Created by J_jie on 16/7/11.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

//实现缩放方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    //设置scrollview的缩放比
    self.scrollView.maximumZoomScale = 3.5;
    self.scrollView.minimumZoomScale = 0.2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
