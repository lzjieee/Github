//
//  AppView.h
//  03-1九宫格
//
//  Created by mac on 16/4/3.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"

//由于希望将AppView.xib拖线到类中实行对xib的控件的操作
//xib里拖一个UIView创建的是时候默认关联UIView（系统类我们不好往里面写自己的代码）
//所以一般让xib里UIView控件关联自己创建的xxxUIView
//注意：如果这些控件想通过外部调用，所以先拖到.h
//     只拖到.m是私有属性
@interface AppView : UIView

@property(nonatomic, strong) App *model;

//自定义一个类方法，这个类方法作用是创建一个view对象
+ (instancetype)appView;

@end
