//
//  ViewController.h
//  UNLimitedRollDemo
//
//  Created by 涂婉丽 on 16/3/17.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol didWithImageDelegate <NSObject>

- (void)didImage:(NSInteger)index;

@end
@interface BannerScrollView : UIView

@property (nonatomic, strong)UIPageControl *pageCtrl;   //翻页标记
@property (nonatomic, strong)NSArray *imgArr;    //滚动视图数据
@property (nonatomic,copy)NSString *imagetype;
@property (nonatomic,weak)id<didWithImageDelegate>delegate;
//加载nib
+(id)createHeader;
//-(void)showTimer;
@end
