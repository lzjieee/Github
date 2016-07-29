//
//  ViewController.m
//  10.1-使用autoresizing实现屏幕适配
//
//  Created by J_jie on 16/7/29.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

/**
 使用autoresizing实现屏幕适配
 原理：参照父容器来设置子控件的frame(利用与父控件的位置关系来设置)
      (注意：autoresizing和autolayout是互斥的，不用同时使用)
 1.用storyboard实现步骤：1.storyboard中禁用autolayout。Files inspector的interface builder document，
                       取消勾选autolayout
                     2.在size inspector设置子控件的autoresizing属性
 
 2.通过代码实现autoresizing，参考10.2
 
 
 */
