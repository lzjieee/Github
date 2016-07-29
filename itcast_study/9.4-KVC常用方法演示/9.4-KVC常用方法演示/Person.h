//
//  Person.h
//  9.4-KVC常用方法演示
//
//  Created by J_jie on 16/7/29.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;

@property (nonatomic, strong) Dog *dog;


@end
