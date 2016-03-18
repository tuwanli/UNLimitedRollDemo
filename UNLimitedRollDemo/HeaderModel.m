//
//  ViewController.h
//  UNLimitedRollDemo
//
//  Created by 涂婉丽 on 16/3/17.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "HeaderModel.h"

@implementation HeaderModel
-(id)initWithHeaderModel:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
//        self.isblack = dic[@"isblack"];
//        self.headerImage = dic[@"headerImage"];
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
