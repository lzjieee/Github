//
//  Menu.h
//  MeituanApp
//
//  Created by mac on 16/9/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, assign, getter = isTopMenu) BOOL topMenu;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)menuWithDict:(NSDictionary *)dict;

@end
