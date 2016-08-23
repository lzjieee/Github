//
//  ViewController.m
//  10.8-通过代码创建约束
//
//  Created by J_jie on 16/8/23.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建蓝色view
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    //blueView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:blueView];
    
    //创建红色view
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    //redView.frame = CGRectMake(0, 100, 100, 100);
    [self.view addSubview:redView];
    
    //关闭autoresizing
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //创建约束
    //1.创建蓝色view的约束(高度50，距离父控件左右上间距30)
    //1.1距离左边30
    //(翻译这个constraintWithItem函数参数：A的xx属性 = B的xx属性 * multiplier + constant)
    //参数1的参数2 参数3 参数4的参数5 * 参数6 + 参数7 (这个由于是设置自身高度，所以参数4传nil，参数5传不是一个属性)
    NSLayoutConstraint *blueHc = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    //把约束添加到控件上（由于是自身属性的修改没参照物，所以添加到自己身上）
    [blueView addConstraint:blueHc];
    
    //这里下面的3个控件都是相对于父控件来设置的，要添加到父控件上
    //1.2距离左边30
    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30];
    
    //1.3距离上边30(self.topLayoutGuide状态栏)
    NSLayoutConstraint *blueTop = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:30];
    //1.4距离右边30
    NSLayoutConstraint *blueRight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30];
    
    [self.view addConstraint:blueLeft];
    [self.view addConstraint:blueTop];
    [self.view addConstraint:blueRight];
    
    //2.创建红色view的约束
    //2.1让红色view的高度=蓝色view的高度
    NSLayoutConstraint *redHc = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    //(这里红色view依赖蓝色view还设置高度了，所以约束添加到他们的第一个父控件中)
    [self.view addConstraint:redHc];
    
    //2.2让红view距离蓝色view30
    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30];
    [self.view addConstraint:redTop];
    
    //2.3红色view和蓝色view右对齐
    NSLayoutConstraint *redRight = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:redRight];
    //2.4红色view的宽度=蓝色的一半
    NSLayoutConstraint *redWc = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    [self.view addConstraint:redWc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
