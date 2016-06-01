//
//  ViewController.m
//  01qq登陆
//
//  Created by J_jie on 16/3/29.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btnClicked:(id)sender;
- (IBAction)btnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)btnClicked:(id)sender;
- (IBAction)btnClicked:(id)sender;
- (IBAction)btnClick:(id)sender;

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

- (IBAction)btnClicked:(id)sender {
}

- (IBAction)btnClicked:(id)sender {
}

- (IBAction)btnClicked:(id)sender {
}

- (IBAction)btnClick:(id)sender
{
    NSLog(@"%@", [NSString stringWithFormat:@"userName=%@", _username.text ]);
    NSLog(@"%@", [NSString stringWithFormat:@"pwd=%@", _pwd.text ]);
}
- (IBAction)btnClick:(id)sender {
}
@end
