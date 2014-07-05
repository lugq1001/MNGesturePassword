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
#import "MNGesturesLockDelegate.h"

@interface ViewController () <MNGesturesLockDelegate>

@property (nonatomic, strong) MNGesturesLockView *gesturesView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gesturesView = [[MNGesturesLockView alloc] initWithConfig:[MNGesturesLockConfig defaults]];
    self.gesturesView.delegate = self;
    [self.view addSubview:self.gesturesView];
}

- (void)didGesturesPasswordCompleted:(NSString *)gesturePassword
{
    [self.gesturesView passwordErrored];
}

@end
