//
//  ViewController.m
//  4-1疯狂猜图
//
//  Created by mac on 16/6/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"

@interface ViewController ()

//所有问题的数据
@property(nonatomic, strong) NSArray *questions;
//控制题目的索引
@property(nonatomic, assign) int index;
//记录原始的题目icon大小
@property(nonatomic, assign) CGRect iconFrame;

@property (weak, nonatomic) IBOutlet UIButton *btnScore;
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;

- (IBAction)btnNextClicked:(id)sender;
- (IBAction)btnBigImage:(id)sender;
- (IBAction)btnSmallImage:(id)sender;
- (IBAction)btnIconClicked:(id)sender;

@end

@implementation ViewController

//懒加载数据-重写Get
- (NSArray *)questions
{
    if (_questions == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Question *model = [Question questionWithDict:dict];
            [arrayModel addObject:model];
        }
        _questions = arrayModel;
    }
    return _questions;
}


//改变状态栏文字的颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化显示第一题
    self.index = -1;
    [self nextQuestion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnNextClicked:(id)sender
{
    NSLog(@"---->btnNextClicked...");
    [self nextQuestion];
}

- (IBAction)btnIconClicked:(id)sender
{
    if([self.view viewWithTag:1000] == nil)
    {
        [self btnBigImage:sender];
    }
    else
    {
        [self btnSmallImage:sender];
    }
}

- (IBAction)btnBigImage:(id)sender
{
    //记录下原始大小
    self.iconFrame = self.btnIcon.frame;
    
    //1.创建一个大小于self.view一样大小的按钮，把这个按钮作为阴影背景
    UIButton *btnCover = [[UIButton alloc] init];
    btnCover.frame = self.view.bounds;
    btnCover.backgroundColor = [UIColor blackColor];
    btnCover.alpha = 0.0;
    btnCover.tag = 1000;
    [self.view addSubview:btnCover];
    //为阴影注册一个单击事件
    [btnCover addTarget:self action:@selector(btnSmallImage:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.设置图片在阴影上面
    [self.view bringSubviewToFront:self.btnIcon];
    //3.通过动画方式放大图片
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconH) * 0.5;
    [UIView animateWithDuration:0.7 animations:^{
        btnCover.alpha = 0.6;
        self.btnIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];
    //**** 注意：如果这句代码走了，图片没放大，可能是因为autolayout（选中mian.storyboard属性中去掉自动布局） ****
    
}

- (IBAction)btnSmallImage:(id)sender
{
    NSLog(@"---->btnSmallImage...");
    //1.设置btnicon按钮的frame还原
    self.btnIcon.frame = self.iconFrame;
    //2.
    UIButton *btnCover = (UIButton *)[self.view viewWithTag:1000];
    [btnCover removeFromSuperview];
}

- (void)nextQuestion
{
    //1.索引++
    self.index++;
    //2.根据索引获取当前的model数据
    Question *model = self.questions[self.index];
    //3.model数据设置到控件上
    [self settingData:model];
    
    //4.动态创建答案按钮
    [self createAnswerBtns:model];
    //5.动态创建待选答案按钮
    [self createOptionsBtns:model];
    
}

//把模型数据设置到界面控件上
- (void)settingData:(Question *)model
{
    //3.model数据设置到控件上
    self.lblIndex.text = [NSString stringWithFormat:@"%d / %ld", (self.index + 1), self.questions.count];
    self.lblTitle.text = model.title;
    [self.btnIcon setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    
    //4.最后一题了，下一题按钮禁用
    self.btnNext.enabled = (self.index != self.questions.count - 1);
}

//动态创建答案按钮
- (void)createAnswerBtns:(Question *)model
{
    //5.动态创建答案按钮
    //5.0先清除上次的
    //    while (self.answerView.subviews.firstObject)
    //    {
    //        [self.answerView.subviews.firstObject removeFromSuperview];
    //    }
    //这个话的意思是，让数组里的每个对象都调用一次 参数中的方法
    [self.answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //5.1当前答案的文字
    NSInteger length = model.answer.length;
    CGFloat answerW = 35;
    CGFloat answerH = 35;
    CGFloat answerY = 0;
    CGFloat margin = 10; //按钮间距
    CGFloat marginLeft = (self.answerView.frame.size.width - (length * answerW) - (length - 1)*margin)/2;
    //5.2根据按钮字数，循环创建答案按钮
    for (int i = 0; i < length; i++)
    {
        UIButton *btnAnswer = [[UIButton alloc] init];
        btnAnswer.backgroundColor = [UIColor whiteColor];
        
        CGFloat answerX = marginLeft + (answerW + margin)*i;
        btnAnswer.frame = CGRectMake(answerX, answerY, answerW, answerH);
        [btnAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.answerView addSubview:btnAnswer];
    }
}

- (void)createOptionsBtns:(Question *)model
{
    [self.optionsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray *words = model.options;
    
    CGFloat optW = 35;
    CGFloat optH = 35;
    CGFloat magin = 19;
    int columns = 7;
    CGFloat marginLeft = (self.optionsView.frame.size.width - (columns * optW) - (columns - 1) * magin)/2;
    
    for (int i = 0; i < words.count; i++)
    {
        UIButton *optionBtn = [[UIButton alloc] init];
        [optionBtn setTitle:words[i] forState:UIControlStateNormal];
        [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //计算坐标
        int columIndex = i % columns;
        int rowIndex = i / columns;
        CGFloat optX = marginLeft + columIndex * (optW + magin);
        CGFloat optY = rowIndex * (magin + optH);
        
        optionBtn.backgroundColor = [UIColor whiteColor];
        optionBtn.frame = CGRectMake(optX, optY, optW, optH);
        [self.optionsView addSubview:optionBtn];
        
        //创建点击事件
        [optionBtn addTarget:self action:@selector(optionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)optionBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //1.隐藏当前被点击的按钮
    btn.hidden = YES;
    //2.将按钮文字显示到第一个为空的答案钮按上
    BOOL isFull = YES;
    NSString *text = [btn titleForState:UIControlStateNormal];
    //text = btn.currentTitle; 获取当前状态下的文字
    for (UIButton *answerBtn in self.answerView.subviews)
    {
        if(answerBtn.currentTitle == nil)
        {
            [answerBtn setTitle:text forState:UIControlStateNormal];
            break;
        }
    }
    
    //3.判断答案是否已经填满了，（满了不能再点击待选按钮）
    for (UIButton *answerBtn in self.answerView.subviews)
    {
        if(answerBtn.currentTitle == nil)
        {
            isFull = NO;
            break;
        }
    }
    if(isFull)
    {
        //这个view不能再和用户交互
        self.optionsView.userInteractionEnabled = NO;
    }
}

@end
