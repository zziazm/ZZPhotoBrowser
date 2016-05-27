//
//  ZZPhotoBrowser.h
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/27.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZPhoto.h"
@interface ZZPhotoBrowser : UIViewController
- (id)initWithBrowserPhotos:(NSArray <ZZPhoto *>* )browserPhotos;
@property (nonatomic, assign) NSUInteger currentIndex;
@end
