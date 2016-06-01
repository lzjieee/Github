//
//  ViewController.m
//  02-4汤姆猫
//
//  Created by J_jie on 16/3/29.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
-(IBAction)btnClicked:(id)sender;

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

-(IBAction)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    //正在动画中，不能执行其他动画
    if(self.imgView.isAnimating)
        return;
    
    if(btn.tag == 0) //播放knockout动画（tom的头部有透明按钮）
    {
        [self startAnimation:80 picName:@"cat_knockout"];
    }
    else if(btn.tag == 1) //播放drink动画
    {
        [self startAnimation:81 picName:@"cat_drink"];
    }
    
}


//执行动画的方法
-(void)startAnimation:(int)count picName:(NSString *)picName
{
    //1.图片动态加载到nsarray中（NSMutableArray动态数组）
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i<count; i++)
    {
        //拼接图片名称（%2d--表示保留两位，%02d--表示保留两位，不足两位前面补一个0）
        NSString *str = [NSString stringWithFormat:@"%@00%02d", picName, i];
        //根据图片名加载图片（这个方法耗内存）
        //UIImage *imgName = [UIImage imageNamed:str];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"jpg"];
        UIImage *imgName = [UIImage imageWithContentsOfFile:path];
        //把图片加载到数组中
        [arrayM addObject:imgName];
    }
    //2.设置uiimageView（图片框）的animationImages属性，这个属性中包含的就是所有那些要执行的动画图片
    self.imgView.animationImages = arrayM;
    //3.设置动画持续时间
    self.imgView.animationDuration = self.imgView.animationImages.count * 0.1;
    //4.设置动画是否需要重复播放
    self.imgView.animationRepeatCount = 1;
    //5.开启动画
    [self.imgView startAnimating];
    /*6.虽然UIImage imageWithContentsOfFile加载图片是不会缓存的，但是从内存看依旧是保持和最后一次
       动画的内存一样？原因是arrayM赋值给了imgView.animationImages，imageView不销毁所以
       imgView.animationImages依然保持了最后一次动画的数据:解决方法，动画播放完以后
       imgView.animationImages置空一下，这句话需要延迟一下执行，确保动画已经执行完了才执行，
       不然会没有动画效果*/
    [self.imgView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imgView.animationImages.count * 0.1];
}

/**
    注意：startAnimation（）函数中，根据图片名加载图片的时候用的是
    UIImage *imgName = [UIImage imageNamed:str]; 
    UIImage imageNamed 会把图片加载到内存中，
    例如刚打开应用是内存是20m--->点击drink(drink的图片被缓存在内存)内存飙升到200m
    ---->点击knock内存飙升到400m（注意再次点击相同动画，内存不会增加了，但是一直点击
    新动画，内存就会飙升）
    
    总结：
        好处：用这种方法加载图片会一直保存在内存不释放，再次加载速度快，不用重新加载
        缺点：加载大量图片的时候占用内存过高
        像这个案例tom有大量图片，应该使用不缓存图片的方法去加载图片
 */

@end
