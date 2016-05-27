//
//  ZZPhoto.h
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/27.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZPhoto : NSObject
//+ (ZZPhoto *)photoWithURL:(NSURL *)url;
@property (nonatomic, strong) NSURL * photoURL;
- (id)initWithURL:(NSURL *)url;
@end
