//
//  ViewController.m
//  10.5-autolayout案例4
//
//  Created by J_jie on 16/8/12.
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

/**
 设置红色view的宽度是蓝色view的一半的思路：
    方法1：先让红色view的width等于蓝色view，然后选中这个约束条件，打开右边的属性，修改multipler为0.5，就实现了
          原理：当设置红色view的width等于蓝色view，内部代码计算红色view的width值执行
                公式 红色width = [蓝色width + constant] * multipler
    
    方法2：先设红色view水平居中，选中这个约束，属性里设置second item 为红色view的leasing（就是左边）再设置红色view的左边等于中线
 
 */

@end
