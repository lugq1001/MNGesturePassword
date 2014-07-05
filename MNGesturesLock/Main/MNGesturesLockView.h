//
//  MNGesturesLockView.h
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import UIKit;

@class MNGesturesLockConfig;
@protocol MNGesturesLockDelegate;

/**
 *  @class MNGesturesLockView
 *  @note  手势密码视图布局
 */
@interface MNGesturesLockView : UIView

@property (nonatomic) id<MNGesturesLockDelegate> delegate;

- (instancetype)initWithConfig:(MNGesturesLockConfig *)config;

/**
 *  密码错误时调用
 */
- (void)passwordErrored;

@end
