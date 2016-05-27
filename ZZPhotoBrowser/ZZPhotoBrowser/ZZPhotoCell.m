//
//  ZZPhotoCell.m
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/27.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import "ZZPhotoCell.h"
#import "BrowserImageView.h"
#import "UIViewAdditions.h"
#import "UIImageView+WebCache.h"
#define kPadding 20
#define kNavigationHeight 0

@implementation ZZPhotoCell
- (id)init{
    self = [super init];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kNavigationHeight);
    self.delegate   = self;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor yellowColor];
    //缩放
    self.bouncesZoom = YES;
    self.maximumZoomScale = 3;
    self.multipleTouchEnabled = YES;
    _imageContainerView = [UIView new];
    [self addSubview:_imageContainerView];
    _imageView = [BrowserImageView new];
    [_imageContainerView addSubview:_imageView];
    _label= [UILabel new];
    _label.frame = CGRectMake(100, 100, 100, 100);
    _label.text = @"kk";
    [self addSubview:_label];
    return self;
}



- (void)setBrowserPhoto:(ZZPhoto *)browserPhoto{
    if (_browserPhoto == browserPhoto) {
        return;
    }
    _browserPhoto = browserPhoto;
    __weak typeof(self) weakSelf = self;
    [_imageView setImageWithURL:browserPhoto.photoURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        //根据图片的size设置imageView的height
        weakSelf.imageContainerView.width = weakSelf.width;
        if (image.size.height / image.size.width > weakSelf.bounds.size.height / weakSelf.size.width) {
            weakSelf.imageContainerView.height = floor(image.size.height / (image.size.width / weakSelf.width));
        } else {
            CGFloat height = image.size.height / image.size.width * weakSelf.width;
            if (height < 1 || isnan(height)) height = weakSelf.height;
            height = floor(height);
            weakSelf.imageContainerView.height = height;
            
            weakSelf.imageContainerView.centerY = weakSelf.height / 2;
        }
        if (weakSelf.imageContainerView.height > weakSelf.height && weakSelf.imageContainerView.height - weakSelf.height <= 1) {
            weakSelf.imageContainerView.height = weakSelf.height;
        }
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        weakSelf.imageView.frame = weakSelf.imageContainerView.bounds;
        [CATransaction commit];
        
    }];
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageContainerView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    UIView *subView = _imageContainerView;
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
    
}

@end
