//
//  ViewController.h
//  UNLimitedRollDemo
//
//  Created by 涂婉丽 on 16/3/17.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderModel.h"
@interface ScrollImageView : UIImageView

@property (nonatomic, copy) void(^TapImageBlock)(NSDictionary *blockDic);

@property (nonatomic, strong) NSString *imgDic;

@property (nonatomic, strong) UILabel *readState;
@property (nonatomic, copy)   NSString *imagetype;
- (id)initWithFrame:(CGRect)frame WithImageDictionary:(HeaderModel *)model imageType:(NSString *)imagetype;

@end
