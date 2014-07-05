//
//  MNGesturesLockDelegate.h
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

/**
 *  @class MNGesturesLockDelegate
 *  @brief 手势密码协议
 */
@protocol MNGesturesLockDelegate <NSObject>

@required

/**
 *  手势轨迹绘制完成
 *
 *  @param gesturePassword 手势密码
 */
- (void)didGesturesPasswordCompleted:(NSString *)gesturePassword;

@end