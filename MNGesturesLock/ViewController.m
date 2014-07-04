//
//  ViewController.m
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "ViewController.h"
#import "MNGesturesLockView.h"
#import "MNGesturesLockConfig.h"

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    MNGesturesLockView *view = [[MNGesturesLockView alloc] initWithConfig:[MNGesturesLockConfig defaults]];
    [self.view addSubview:view];
}

@end
