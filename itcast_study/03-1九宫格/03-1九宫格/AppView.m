//
//  AppView.m
//  03-1九宫格
//
//  Created by mac on 16/4/3.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "AppView.h"

@interface AppView()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *downLo;
- (IBAction)btnDownloadClick:(id)sender;

@end

@implementation AppView

//提供这个创建view的类方法是因为虽然controller的viewdidload里也可以创建，但是controller
//只是用view，不用管view的创建。封装起来更安全，代码耦合度更低
+ (instancetype)appView
{
    //1.通过xib创建每个应用的小uiview
    //通过动态加载xib
    //1.1找到手机根目录
    NSBundle *rootPath = [NSBundle mainBundle];
    //1.2在应用程序根目录下读取对应的xib（nib）。开发的时候叫xib，部署到设备上就nib
    //下面这个函数返回的是nsarray。
    AppView *appView = [[rootPath loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
    return appView;
}


//重写model的set方法
-(void)setModel:(App *)model
{
    //先赋值
    _model = model;
    
    //解析模型数据，把模型数据赋值给uiview的各个子控件
    self.imgView.image = [UIImage imageNamed:model.icon];
    self.nameLabel.text = model.name;
}

- (IBAction)btnDownloadClick:(id)sender
{
    //1.禁用当前按钮
    UIButton *btn = (UIButton *)sender;
    btn.enabled = false;
    //2.弹出一个消息提醒框（uilabel）
    UILabel *labelMsg = [[UILabel alloc] init];
    //3.把label添加到大view上
    UIView *rootView = self.superview;
    [rootView addSubview:labelMsg];
    //4.设置label的属性
    labelMsg.text = @"loading...";
    labelMsg.textAlignment = NSTextAlignmentCenter;
    labelMsg.textColor = [UIColor redColor];
    labelMsg.backgroundColor = [UIColor blackColor];
    //一开始把动画设置成0，然后用动画慢慢显示到0.5f（渐现效果）
    labelMsg.alpha = 0;
    labelMsg.frame = CGRectMake(rootView.center.x - 100, rootView.center.y - 15, 200, 30);
    //5.设置label圆角效果
    //5.1设置四周圆角的半径
    labelMsg.layer.cornerRadius = 15;
    //5.2把多余的角裁剪掉
    labelMsg.layer.masksToBounds = YES;
    
    //6.通过动画显示label
    //开始一个动画执行2.0s
    [UIView animateWithDuration:2.0 animations:^{
        //动画代码-将透明度边0.5，label显示了
        labelMsg.alpha = 0.5f;
    } completion:^(BOOL finished){
        //当上面的动画执行完毕执行下面的代码（第二个动画时间1.5s，延迟1s执行）
        [UIView animateWithDuration:1.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            labelMsg.alpha = 0;
        } completion:^(BOOL finished) {
            //第二个动画执行完毕，label隐藏了，删除label
            [labelMsg removeFromSuperview];
        }];
    }];
    
}
@end
