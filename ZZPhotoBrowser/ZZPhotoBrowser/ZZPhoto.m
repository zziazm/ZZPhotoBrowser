//
//  ZZPhoto.m
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/27.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import "ZZPhoto.h"

@implementation ZZPhoto
- (id)initWithURL:(NSURL *)url{
    self = [super init];
    if (self) {
        _photoURL = url;
    }
    return self;
}
@end
