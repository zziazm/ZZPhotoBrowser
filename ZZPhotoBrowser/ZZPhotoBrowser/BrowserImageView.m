//
//  BrowserImageView.m
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/27.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import "BrowserImageView.h"
#import "UIImageView+WebCache.h"

@implementation BrowserImageView
-(void)setUrl:(NSURL *)url{
    if (_url == url) {
        return;
    }
    [self setImageWithURL:url];
}
@end
