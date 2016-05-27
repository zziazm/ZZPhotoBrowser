//
//  ZZPhotoBrowser.m
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/27.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import "ZZPhotoBrowser.h"
#import "ZZPhoto.h"
#import "BrowserImageView.h"
#import "ZZPhotoCell.h"
#define kNavigationHeight 0
#import "UIViewAdditions.h"
#define kPadding 10

@interface ZZPhotoBrowser ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray <ZZPhoto *>* browserPhotos;
@property (nonatomic, strong) NSMutableArray <ZZPhotoCell *>* photoViews;
@property (nonatomic, assign) NSInteger currentPage;


@end


@implementation ZZPhotoBrowser
- (id)initWithBrowserPhotos:(NSArray<ZZPhoto *> *)browserPhotos{
    self = [super init];
    if (self) {
        _browserPhotos = [browserPhotos mutableCopy];
        _photoViews = @[].mutableCopy;
    }
    return self;
}

- (void)viewDidLoad{
    //    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.alpha = 0.5;
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , [UIScreen mainScreen].bounds.size.width + 10, [UIScreen mainScreen].bounds.size.height - kNavigationHeight)];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * _browserPhotos.count ,0);
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor yellowColor];
    
    //    [_scrollView scrollRectToVisible:CGRectMake(_currentIndex * _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];
    _scrollView.contentOffset = CGPointMake(_currentIndex*_scrollView.width, 0);
    [self scrollViewDidScroll:self.scrollView];
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:singleTap];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [singleTap requireGestureRecognizerToFail:tap];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}

#pragma mark -- Action
- (void)singleTap:(UITapGestureRecognizer *)singleTap{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)doubleTap:(UITapGestureRecognizer *)tap{
    ZZPhotoCell * view = [self viewForPage:self.currentPage];
    if (view) {
        if (view.zoomScale >1) {
            [view setZoomScale:1 animated:YES];
        }else{
            CGPoint touchPoint = [tap locationInView:view.imageView];
            CGFloat newZoomScale = view.maximumZoomScale;
            CGFloat xsize = view.bounds.size.width/ newZoomScale;
            CGFloat ysize = view.bounds.size.height / newZoomScale;
            [view zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        }
    }
}

//更新复用的视图
- (void)updateViewsForReuse{
    for (ZZPhotoCell * view in _photoViews) {
        if (view.superview) {
            if (CGRectGetMaxX(view.frame)<= _scrollView.contentOffset.x - _scrollView.frame.size.width || CGRectGetMinX(view.frame) >= _scrollView.contentOffset.x + 2*_scrollView.frame.size.width) {
                [view removeFromSuperview];
                [view setZoomScale:1 animated:YES];
                view.browserPhoto = nil;
                view.page = -1;
            }
        }
    }
}

- (ZZPhotoCell *)dequeueReuseView{
    ZZPhotoCell * view = nil;
    for (view in self.photoViews) {
        if (!view.superview) {
            return view;
        }
    }
    view = [[ZZPhotoCell alloc] init];
    view.frame = CGRectMake(0, 0, _scrollView.width, _scrollView.height);
    //    view.imageContainerView.frame = _scrollView.bounds;
    //    view.imageView.frame = _scrollView.bounds;
    view.page= -1;
    [self.photoViews addObject:view];
    return view;
}

- (ZZPhotoCell *)viewForPage:(NSInteger)page{
    for (ZZPhotoCell *view in _photoViews) {
        if (view.page == page) {
            return view;
        }
    }
    return nil;
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateViewsForReuse];
    NSInteger page = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    for (NSInteger i = page - 1; i <= page + 1; i++) {
        if (i>=0&& i<self.browserPhotos.count) {
            ZZPhotoCell * view = [self viewForPage:i];
            if (!view) {
                view = [self dequeueReuseView];
                view.page = i;
                view.browserPhoto = self.browserPhotos[i];
                view.frame = CGRectMake(i*_scrollView.bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, _scrollView.bounds.size.height);
                [self.scrollView addSubview:view];
            }
        }
    }
    _currentPage = page;
}// any offset change
- (void)didReceiveMemoryWarning{
    
}

@end
