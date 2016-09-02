//
//  ViewController.m
//  MeituanApp
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Menu.h"
#import "Item.h"

@interface ViewController ()

@property(nonatomic, strong) NSArray *menus;
@property(nonatomic, strong) NSArray *items;

@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSArray *)menus
{
    if (_menus == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Menu.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Menu *model = [Menu menuWithDict:dict];
            [arrayModel addObject:model];
        }
        _menus = arrayModel;
    }
    return _menus;
}

- (NSArray *)items
{
    if(_items == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Item.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict)
        {
            Item *model = [Item itemWithDict:dict];
            [arrayModel addObject:model];
        }
        _items = arrayModel;
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%ld", self.items.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
