//
//  ViewController.m
//  10.6-实例游戏界面屏幕适配
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
 iphone 分辨率:
 
 设备     屏幕尺寸    分辨率(pt)     reader   需要的资源大小
 3gs      3.5        320*480        @1x       320*480
 4/4s     3.5        320*480        @2x       640*960
 5/5s/5c  4.0        320*568        @2x       640*1136
 6/6s     4.7        375*667        @2x       750*1334
 6 plus   5.5        414*736        @3x       1242*2208
 */


/**
 史上最牛游戏屏幕适配案例步骤：
    1.拖一个uiimageview，添加背景图，设置约束垂直水平居中对齐
        main.storyboard右下角的4个按钮点击Align按钮，勾选horizontally in container和vertically in container
        *注意：像按钮，开关，label，图片框这些控件可以不指定width和hight，指定了xy后系统会根据内容大小自动设置
        *注意：经过上面的步骤以后已经已经适应了iphone6之前的屏幕了，但是iphone6以后的就会有空白的地方了。
            因为背景（720*1136）比6和6 plus所需的资源大小小了
    2.由于背景（720*1136）比6和6 plus所需的资源大小小了，所以要对6和6 plus进行假适配(拉伸图片)
        
 */

@end
