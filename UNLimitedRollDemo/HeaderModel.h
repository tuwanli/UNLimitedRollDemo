//
//  ViewController.h
//  UNLimitedRollDemo
//
//  Created by 涂婉丽 on 16/3/17.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject
@property(nonatomic,copy)NSString *image;//图片
@property (nonatomic,copy)NSString *title;

//@property(nonatomic,assign)BOOL isblack;//是否是黑色字体显示时间
//构造方法
-(id)initWithHeaderModel:(NSDictionary *)dic;
@end
