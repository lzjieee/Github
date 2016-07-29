//
//  main.m
//  9.4-KVC常用方法演示
//
//  Created by J_jie on 16/7/29.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // ---------直接为对象的属性赋值----------------------
        Person *p1 = [[Person alloc] init];
        p1.name = @"张三";
        
        Dog *chihuahua = [[Dog alloc] init];
        chihuahua.name = @"吉娃娃";
        p1.dog = chihuahua;
        
        NSLog(@"%@ --- %@", p1.name, p1.dog.name);
        // ------------------------------------------------
        
        
        // ----------通过kvc的方式为对象赋值(这样更灵活，因为可以用一个变量来表示forKeyPath的值)---------
        Dog *husky = [[Dog alloc] init];
        husky.name = @"哈士奇";
        
        [p1 setValue:@"李四" forKeyPath:@"name"];
        [p1 setValue:@10 forKeyPath:@"age"];
        [p1 setValue:husky forKeyPath:@"dog"];
        NSLog(@"%@ --- %d", p1.name, p1.age);
        NSLog(@"%@", p1.dog.name);
        
        //注意：@"husky.name"这个就叫keyPath(属性的路径)，setValue forKey 不能这样写
        [p1 setValue:@"哈士奇" forKeyPath:@"dog.name"];
        
        
        // 演示：可以用一个变量来表示forKeyPath的值(可以随便改value和property，不影响赋值语句)
        NSString *value = @"xxx";
        NSString *property = @"name";
        [p1 setValue:value forKeyPath:property];
        NSLog(@"%@", p1.name);
        
        //--------------------------------------------------------------------------------------
        
        //---------- 创建NSDictionary，通过setValuesForKeysWithDictionary赋值 ----------
        Person *p2 = [[Person alloc] init];
        NSDictionary *bz = @{
                             @"name" : @"henry",
                             @"age"  : @28,
                             @"dog": @{@"name" : @"道奇"},
                             };
        
        [p2 setValuesForKeysWithDictionary:bz];
        NSDictionary *dogDict = (NSDictionary *)p2.dog;
        NSLog(@"%@--%d--%@",p2.name, p2.age, dogDict[@"name"]);
        
        //----------------------------------------------------------------------------
        
        
        //---------------- valueForKeyPath取值 ---------------------
        
        Person *p3 = [[Person alloc] init];
        p3.name = @"张三";
        
        Dog *chihuahua1 = [[Dog alloc] init];
        chihuahua1.name = @"吉娃娃";
        p3.dog = chihuahua1;
        
        NSString *name = [p3 valueForKeyPath:@"name"];
        NSString *dogName = [p3 valueForKeyPath:@"dog.name"];
        
        //---------------------------------------------------------
        
        
        //-------------- 对象转字典 ---------------
        
        Person *p4 = [[Person alloc] init];
        p4.name = @"张三";
        
        Dog *chihuahua2 = [[Dog alloc] init];
        chihuahua2.name = @"吉娃娃";
        p4.dog = chihuahua2;
        
        NSDictionary *dict = [p4 dictionaryWithValuesForKeys:@[@"name", @"dog"]];
        NSLog(@"%@", dict);
        //---------------------------------------
    }
    return 0;
}
