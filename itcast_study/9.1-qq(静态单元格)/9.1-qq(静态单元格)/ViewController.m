//
//  ViewController.m
//  9.1-qq(静态单元格)
//
//  Created by J_jie on 16/7/27.
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
    tableview静态单元格创建步骤：
    1.删除storyboard中默认的viewcontroller(因为静态cell只能创建在tableviewController中)
    2.拖一个tableviewController
    3.选中tableviewController，右边viewController属性栏中，勾上is inital view controller（程序启动默认viewController）
    4.选中tableview，修改属性content为static cells
    5.选中tableview cell 修改样式为basic（icon + name 的样式）
    6.添加最右边的小箭头选中tableview cell，修改accessory属性为disclosure indicator
 
    7.不想要分组的样式，选中tableview，先设置style为grouped，再设置分组属性，选中tableview，修改section为3
    8.选中tableview section ，修改rows，可以改变每组的行数
 */

@end
