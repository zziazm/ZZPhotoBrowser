//
//  ZZPhotoCell.h
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/27.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZPhoto.h"
#import "BrowserImageView.h"

@interface ZZPhotoCell : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) ZZPhoto * browserPhoto;
@property (nonatomic, strong) BrowserImageView * imageView;
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIView * imageContainerView;


@end
