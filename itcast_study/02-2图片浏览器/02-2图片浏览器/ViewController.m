//
//  ViewController.m
//  02-2图片浏览器
//
//  Created by J_jie on 16/3/29.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

//用于保存plist加载的数据
@property(nonatomic, strong) NSArray *pic;

//当前的索引index
@property(nonatomic, assign) int index;

-(IBAction)btnClicked:(id)sender;

@end

@implementation ViewController

//重写pic的get方法
//------------- （懒加载） ------------直到你调对象的get方法时才加载
- (NSArray *)pic
{
    if(_pic == nil)
    {
        //写代码加载pic.plist文件的数据到_pic
        //------1.获取plist的路径--------
        //NSBundle mainBundle 获取将来软件安装到手机的app的根目录
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pic.plist" ofType:nil];
        //------2.读取文件--------
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"%@", array);
        _pic = array;
    }
    return _pic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _index = 0;
    NSDictionary *dict = self.pic[_index];
    self.imgView.image = [UIImage imageNamed:dict[@"icon"]];
    self.titleLabel.text = dict[@"title"];
    self.numberLabel.text = [NSString stringWithFormat:@"%d/%ld", _index + 1, _pic.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //改变索引
    if(btn.tag == 1)
    {
        if(_index == 0)
            return;
        _index--;
    }
    else if(btn.tag == 2)
    {
        if(_index == _pic.count - 1)
            return;
        _index++;
    }
    
    //获取数组当前index的图片数据
    NSDictionary *dict = _pic[_index];
    
    //显示图片
    self.imgView.image = [UIImage imageNamed:dict[@"icon"]];
    //改标题、索引
    self.numberLabel.text = [NSString stringWithFormat:@"%d/%ld", _index + 1, _pic.count];
    self.titleLabel.text = dict[@"title"];
}

//-------------------------------------------------------
//创建.plist的原理，先构建数据，然后根据类型手动兴建.plist
//    NSDictionary *dict1 = @{@"name":@"jack", @"age":@18, @"height":@180};
//    NSDictionary *dict2 = @{@"name":@"mike", @"age":@19, @"height":@160};
//    NSDictionary *dict3 = @{@"name":@"lam", @"age":@22, @"height":@189};
//    
//    NSArray *students = @[dict1, dict2, dict3];
//-------------------------------------------------------


@end
