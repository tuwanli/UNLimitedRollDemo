//
//  ViewController.m
//  UNLimitedRollDemo
//
//  Created by 涂婉丽 on 16/3/17.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "RollMainVC.h"
#import "BannerScrollView.h"
#import "HeaderModel.h"
@interface RollMainVC ()<didWithImageDelegate>
{
    
    BannerScrollView *banView;
}
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSArray *netArr;
@property (nonatomic,copy)NSString *imageType;

@end

@implementation RollMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     *显示网络图片
     */
    NSDictionary *dict1 = @{@"image":@"http://www.pj-hospital.com/d/file/998885555544/2014-04-28/06cca200bf633ab6868e499a0657fec0.jpg",@"title":@"盘锦市中心医院"};
    NSDictionary *dict2 = @{@"image":@"http://www.pj-hospital.com/d/file/998885555544/2014-04-28/f23199a3db612e6e3758840b4a5a0753.jpg",@"title":@"院内展示"};
    NSDictionary *dict3 = @{@"image":@"http://www.pj-hospital.com/d/file/998885555544/2014-04-28/1893b9d20b9a0da0ca7c2f1747a5be72.jpg",@"title":@"鄂尔多斯市中心医院"};
    NSDictionary *dict4 = @{@"image":@"http://www.pj-hospital.com/d/file/998885555544/2014-04-28/4307e2e9d6a490821c8e99c23957e82d.jpg",@"title":@"桓仁中心医院"};
    _netArr= [[NSMutableArray alloc]initWithObjects:dict1,dict2,dict3,dict4, nil];
    _imageType = @"网络";
    /*
     *显示本地图片
     */
    NSDictionary *dict5 = @{@"image":@"1",@"title":@"盘锦市中心医院"};
    NSDictionary *dict6 = @{@"image":@"2",@"title":@"院内展示"};
    NSDictionary *dict7 = @{@"image":@"3",@"title":@"鄂尔多斯市中心医院"};
    NSDictionary *dict8 = @{@"image":@"4",@"title":@"桓仁中心医院"};
    _imageType = @"本地";
    _netArr= [[NSMutableArray alloc]initWithObjects:dict5,dict6,dict7,dict8, nil];
    /*
     代码如下
     */
    banView = [BannerScrollView createHeader];
    banView.delegate = self;
    banView.imagetype = _imageType;
    banView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    banView.imgArr = self.array;
    
    [self.view addSubview:banView];
    

}
- (NSArray *)array
{
    if (_array == nil) {
        _array = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in _netArr) {
            HeaderModel *model = [[HeaderModel alloc]initWithHeaderModel:dict];
            [_array addObject:model];
        }
    }
    return _array;
}
- (void)didImage:(NSInteger)index
{

    NSLog(@"点击第%d张图片",index+1);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
