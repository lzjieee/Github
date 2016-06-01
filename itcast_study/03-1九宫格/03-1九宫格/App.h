//
//  App.h
//  03-1九宫格
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 lzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;

//这两个方法是套路：其他人调用的时候不用重复写解析代码，因为封装到了initWithDict函数中解析，
//外人调用只需穿一个NSDictionary数据来就会返回一个解析好的app对象
/**
 这里还要注意返回值！这里的返回值写App *不太好。
 原因当子类继承了父类的initWithDict，appWithDict返回的应该是子类对象，
 所以你会想到将返回值改为”id“但是，这样的话你就可以用任意的类型去接受这个函数的返回值
 例如NSString，意思是用了一个NSString指针指向了App对象，这不会报错，
 但是当你想调用这个NSString指针的类方法（例如length）时，运行时就会报错，因为App没有length这个方法。
 所以这里最好用返回值instancetype:这个方法是属于哪个类的，返回值就是哪个类的指针
 */
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)appWithDict:(NSDictionary*)dict;
@end
