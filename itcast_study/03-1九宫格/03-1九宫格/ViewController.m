//
//  ViewController.m
//  03-1九宫格
//
//  Created by J_jie on 16/3/30.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"
#import "App.h"
#import "AppView.h"

@interface ViewController ()

//保存app的数据
@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

//懒加载数据（重写get方法） 数据--》转模型
-(NSArray*) dataArray
{
    if(_dataArray == nil)
    {
        //1.获取app.plist文件在手机上的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"App.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        //3.创建一个可变数组来保存一个个模型对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        //4.循环字典数组，把每个字典对象转成一个模型对象
        for (NSDictionary *dict in array)
        {
            //创建一个模型
            App *model = [[App alloc] initWithDict:dict];
            //把模型加到model中
            [arrayModels addObject:model];
        }
        _dataArray = arrayModels;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self createAppViewByCode];
    
    //每行3个app
    int colums = 3;
    //每个应用的宽高
    CGFloat appWidth = 75;
    CGFloat appHeight = 90;
    //上间距
    CGFloat marginTop = 30;
    //左右间距
    CGFloat marginX = (self.view.frame.size.width - appWidth * colums) / (colums + 1);
    //假设上下间距和左右间距相等
    CGFloat marginY = marginX;
    
    for(int i = 0;i<self.dataArray.count;i++)
    {
        CGFloat appY = marginTop + i/colums * (appHeight + marginY);
        CGFloat appX = marginX + i%colums * (appWidth + marginX);
        
        //1.调用自定义appView的类方法创建view
        AppView *appView = [AppView appView];
        
        //2.设置appView的属性
        appView.frame = CGRectMake(appX, appY, appWidth, appHeight);
        //appView.backgroundColor = [UIColor blueColor];
        //3.将appView添加到view中
        [self.view addSubview:appView];
        
        //4.设置appView子控价的数据
        //设置数据有两个方法：1、我提供方法，你传数据进来，我方法就帮你把界面改好。
        //       2.我直接让你自己去每个控键赋值。显然方法1好，安全(别人只能改数据。不能改控件属性)，别人用得也爽
        App *model = self.dataArray[i];
        //下面的代码等于调用model的set方法，appView类中重写了model的set为view的子控件赋值
        appView.model = model;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)downloadClicked
{
    
}

/**
 createAppViewByCode这个函数实现了用纯代码创建每个应用的uiview（以及里面的子控件）
 改进：由于循环创建，其实可以用xib先把uivew（包含子控件）创建好，用代码循环加载xib就好了
 */
-(void)createAppViewByCode
{
    //每行3个app
    int colums = 3;
    //每个应用的宽高
    CGFloat appWidth = 75;
    CGFloat appHeight = 90;
    //上间距
    CGFloat marginTop = 30;
    //左右间距
    CGFloat marginX = (self.view.frame.size.width - appWidth * colums) / (colums + 1);
    //假设上下间距和左右间距相等
    CGFloat marginY = marginX;
    
    for(int i = 0;i<self.dataArray.count;i++)
    {
        CGFloat appY = marginTop + i/colums * (appHeight + marginY);
        CGFloat appX = marginX + i%colums * (appWidth + marginX);
        
        //1.创建每个应用的小uiview
        UIView *appView = [[UIView alloc] init];
        //2.设置appView的属性
        appView.frame = CGRectMake(appX, appY, appWidth, appHeight);
        //appView.backgroundColor = [UIColor blueColor];
        //3.将appView添加到view中
        [self.view addSubview:appView];
        
        //4.向view添加3个子控件
        UIImageView *img = [[UIImageView alloc] init];
        //img.backgroundColor = [UIColor yellowColor];
        CGFloat iconW = 45;
        CGFloat iconH = 45;
        CGFloat iconX = (appView.frame.size.width - iconW) / 2;
        CGFloat iconY = 0;
        img.frame = CGRectMake(iconX, iconY, iconW, iconH);
        [appView addSubview:img];
        UILabel *label = [[UILabel alloc] init];
        //label.backgroundColor = [UIColor redColor];
        label.frame = CGRectMake(0, iconH, appWidth, 20);
        [appView addSubview:label];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        //btn.backgroundColor = [UIColor grayColor];
        btn.frame = CGRectMake(iconX, iconH+20, iconW, 20);
        [appView addSubview:btn];
        
        //5.向子控件添加数据
        // 拿到当前app的数据
        App *app = self.dataArray[i];
        img.image = [UIImage imageNamed:app.icon];
        label.text = app.name;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        //小技巧：像按钮这类有不同状态的控件，设置文字等，不能通过 .xxx（属性来设置）
        //       要通过方法设置，一般要指定什么状态的
        [btn setTitle:@"下载" forState:UIControlStateNormal];
        [btn setTitle:@"已下载" forState:UIControlStateDisabled];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_1"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_2"] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(downloadClicked) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
