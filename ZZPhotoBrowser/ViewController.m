//
//  ViewController.m
//  ZZPhotoBrowser
//
//  Created by 赵铭 on 16/5/26.
//  Copyright © 2016年 zziazm. All rights reserved.
//

#import "ViewController.h"
#import "ZZPhoto.h"
#import "ZZPhotoBrowser.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)push:(id)sender {
        NSArray * images = @[@"http://pbs.twimg.com/profile_images/473830458556297216/40KlXkaR_normal.jpeg", @"http://s2.51cto.com/wyfs02/M02/7F/2A/wKiom1cVlkqSCtYhAAN95oFcYw4487.png-wh_651x-s_7285891.png", @"http://s4.51cto.com/wyfs02/M02/7F/31/wKiom1cWBoLwQoxwAADf1u5gAJA499.jpg-wm_1-wmp_4-s_649566869.jpg-wh_651x-s_721261413.jpg", @"http://s2.51cto.com/wyfs02/M01/7F/24/wKiom1cUtfvSc7wcAAB4ZjZh2WY826.jpg-wh_651x-s_4098158643.jpg", @"http://s3.51cto.com/wyfs02/M01/7F/29/wKiom1cVjd_Q1Eg_AABeqennt0E901.jpg-wh_651x-s_32750796.jpg", @"http://s3.51cto.com/wyfs02/M00/7F/25/wKiom1cUxTXQ1jfxAACPqG1ItuU706.jpg-wh_651x-s_914718217.jpg", @"http://s2.51cto.com/wyfs02/M00/7F/1C/wKiom1cUOjTDZVihAACrvG1cRvs728.jpg-wh_651x-s_916610376.jpg"];
        NSMutableArray * photos = @[].mutableCopy;
        for (NSString * url in images) {
            ZZPhoto * photo = [[ZZPhoto alloc] initWithURL:[NSURL URLWithString:url]];
            [photos addObject:photo];
        }
        ZZPhotoBrowser * bVC = [[ZZPhotoBrowser alloc] initWithBrowserPhotos:photos];
        bVC.currentIndex = 2;
        [self presentViewController:bVC animated:YES completion:nil];
    
}

@end
