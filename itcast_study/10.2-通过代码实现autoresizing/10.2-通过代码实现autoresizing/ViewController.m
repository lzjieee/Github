//
//  ViewController.m
//  10.2-通过代码实现autoresizing
//
//  Created by J_jie on 16/8/3.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak)UIView *blueView;

- (IBAction)btnClicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个蓝色view
    UIView *blueVw = [[UIView alloc] init];
    blueVw.backgroundColor = [UIColor blueColor];
    blueVw.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:blueVw];
    self.blueView = blueVw;
    
    //创建一个红色view
    UIView *redVw = [[UIView alloc] init];
    redVw.backgroundColor = [UIColor redColor];
    //把红色view加到蓝色view里
    [blueVw addSubview:redVw];
    
    CGFloat redW = blueVw.frame.size.width;
    CGFloat redH = 50;
    CGFloat redX = 0;
    CGFloat redY = blueVw.frame.size.height - redH;
    redVw.frame = CGRectMake(redX, redY, redW, redH);
    
    //设置autoresizing
    //设置红色view的距离蓝色view底部的距离保持不变
    /*
     UIViewAutoresizingNone                 = 0,
     UIViewAutoresizingFlexibleLeftMargin   控件左边伸缩，意味着控件右边与父控件距离保持不变,
     UIViewAutoresizingFlexibleWidth        宽度会随着父控件的变化而变化,
     UIViewAutoresizingFlexibleRightMargin  ,
     UIViewAutoresizingFlexibleTopMargin    ,
     UIViewAutoresizingFlexibleHeight       ,
     UIViewAutoresizingFlexibleBottomMargin
     */
    redVw.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
}

- (IBAction)btnClicked:(id)sender
{
    //每次增加蓝色view的宽度高度
    CGRect blueFrame = self.blueView.frame;
    blueFrame.size.width += 20;
    blueFrame.size.height += 20;
    
    self.blueView.frame = blueFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
