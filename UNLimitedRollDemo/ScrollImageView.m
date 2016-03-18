//
//
//  ViewController.h
//  UNLimitedRollDemo
//
//  Created by 涂婉丽 on 16/3/17.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "ScrollImageView.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"


@implementation ScrollImageView

- (id)initWithFrame:(CGRect)frame WithImageDictionary:(HeaderModel *)model imageType:(NSString *)imagetype
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.imgDic = model.image;
        self.imagetype = imagetype;
        [self _initView:model.title];
    }
    return self;
}

- (void)_initView:(NSString *)title
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 270, [UIScreen mainScreen].bounds.size.width, 30)];
    
    lable.backgroundColor = [UIColor blackColor];
    [lable setTextColor:[UIColor whiteColor]];
    lable.alpha = 0.6;
    
    [lable setText:[NSString stringWithFormat:@"  %@",title]];
    [self addSubview:lable];
    
    if ([_imagetype isEqualToString:@"网络"]) {
        NSString *urlStr = self.imgDic;
        NSURL *url = nil;
        
        if ([urlStr isKindOfClass:[NSString class]]) {
            url = [NSURL URLWithString:urlStr];
        } else if ([urlStr isKindOfClass:[NSURL class]]) { // 兼容NSURL
            url = (NSURL *)urlStr;
        }
        
        
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
        if (image) {
            self.image = image;
        } else {
            [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    self.image = image;
                } else {
                    
                }
            }];
        }

    }else if ([_imagetype isEqualToString:@"本地"]){
    
        self.image = [UIImage imageNamed:_imgDic];
    }
    
}


@end
