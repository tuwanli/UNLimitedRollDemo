//
//  ViewController.h
//  UNLimitedRollDemo
//
//  Created by 涂婉丽 on 16/3/17.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//


#import "BannerScrollView.h"
#import "ScrollImageView.h"
#import "UIViewExt.h"
#import "HeaderModel.h"
@interface BannerScrollView ()<UIScrollViewDelegate>
{
    NSInteger _count;       //定时器执行次数
    
    BOOL _isTimer;          //是否是定时滚动
}
//滑动
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)NSTimer *timer;            //定时器
//小时
//@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@end

@implementation BannerScrollView
//创建nib
+(id)createHeader
{
    return [[[NSBundle mainBundle]loadNibNamed:@"HomePageScrollView" owner:nil options:nil] lastObject];
}
- (void)setImgArr:(NSMutableArray *)imgArr {
    if (_imgArr != imgArr) {
        _imgArr = imgArr;
        
        if (_imgArr.count > 1) {
            
            [self _initScrollView];
            
            [self _initPageCtrl];
        }else {
            //  单张图片不轮播
            [self creatOneView];
        }
    }
}
- (void)setImagetype:(NSString *)imagetype
{

    _imagetype = imagetype;
}
- (void)_initPageCtrl {
    //pageController
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - _imgArr.count*20.f), self.frame.size.height - 20.f, _imgArr.count*20.f, 20.f)];
    _pageCtrl.numberOfPages = _imgArr.count;
    _pageCtrl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageCtrl.currentPageIndicatorTintColor = [UIColor whiteColor];
//    _pageCtrl.hidden = YES;
    [self addSubview:_pageCtrl];
}

- (void)_initScrollView {
    //设置头部滚动视图
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * (_imgArr.count + 2), self.frame.size.height);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    //加载一个点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIamge:)];
    [_scrollView addGestureRecognizer:tap];
    
    //左
    HeaderModel *leftmodel = [_imgArr lastObject];
    ScrollImageView *firstView = [[ScrollImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) WithImageDictionary:leftmodel imageType:_imagetype];
    //中
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(self.width, 0, self.width * _imgArr.count, self.height)];
    //右
    HeaderModel *rightmodel = [_imgArr firstObject];
    ScrollImageView *lastView = [[ScrollImageView alloc] initWithFrame:CGRectMake( centerView.right, 0, self.width, self.height) WithImageDictionary:rightmodel imageType:_imagetype];
    
    
    //将滚动视图偏移量设置为中间视图显示
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    _count = 0;
    _isTimer = YES;
    
    [_scrollView addSubview:firstView];
    [_scrollView addSubview:centerView];
    [_scrollView addSubview:lastView];
    
    //添加轮播图片及点击事件
    for (int i = 0; i < _imgArr.count; i++) {
        HeaderModel *model = _imgArr[i];
        ScrollImageView *imgView = [[ScrollImageView alloc] initWithFrame:CGRectMake(self.width * i, 0, self.width, self.height) WithImageDictionary:model imageType:_imagetype];
       
        [centerView addSubview:imgView];
    }
    if (!_timer) {
        //定时器，图片自动循环
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark------点击图片事件
-(void)clickIamge:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_scrollView];
    NSInteger index = point.x / self.width;
    NSInteger count = (index%_imgArr.count) -1;
    if (count < 0) {
        count = _imgArr.count-1;
    }
    if ([self.delegate respondsToSelector:@selector(didImage:)]) {
        [self.delegate didImage:count];
    }
//    NSLog(@"%li",count);
}

#pragma mark - TimerAction
- (void)timerAction:(NSTimer *)timer {
    _count++;
    _pageCtrl.currentPage = _count % _imgArr.count;
    
    _isTimer = YES;
    //字体颜色
//    HeaderModel *model = _imgArr[_count % _imgArr.count];
//    [_hourLabel setText:model.title];

    
    //设置滚动视图动画效果
    if (_scrollView.contentOffset.x == 0)
    {
        
        _scrollView.contentOffset = CGPointMake(self.width * _imgArr.count, 0);
    }
    else if (_scrollView.contentOffset.x == (self.width * _imgArr.count + self.frame.size.width))
    {
        
        _scrollView.contentOffset = CGPointMake(self.width, 0);
    }
    
    [UIView animateWithDuration:.5 animations:^{
        //设置滚动视图偏移量，滚动到指定位置
        float headerView_left = _scrollView.contentOffset.x;
        _scrollView.contentOffset = CGPointMake(headerView_left + self.width, 0);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //手动滑动时执行以下操作
    if (!_isTimer) {
        
        //滚动视图向右滑动到左边视图位置时
        if (_scrollView.contentOffset.x == 0) {
            
            //设置偏移量为中间视图最后一个imgView的位置
            _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * _imgArr.count, 0);
            
        }else if (_scrollView.contentOffset.x == _scrollView.frame.size.width * _imgArr.count + _scrollView.frame.size.width) {
            //滚动视图向左滑动到右边视图位置时
            //设置偏移量为中间视图第一个imgView的位置
            _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
        }
        
        _pageCtrl.currentPage = (NSInteger)((_scrollView.contentOffset.x + _scrollView.width/2)/ _scrollView.frame.size.width - 1) % [_imgArr count];
        
        _count = _pageCtrl.currentPage;
//        HeaderModel *model = _imgArr[_count];
        
//        [_hourLabel setText:model.title];

        
    }
    
}

//开始滑动销毁timer
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer invalidate];
    _isTimer = NO;
}

//滑动结束创建timer
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //定时器，图片自动循环
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

//  单张图片
- (void)creatOneView {
    HeaderModel *model = [_imgArr lastObject];
    ScrollImageView *centerView = [[ScrollImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) WithImageDictionary:model imageType:_imagetype];
    [self addSubview:centerView];
}

//系统方法
-(void)awakeFromNib
{

}



@end
