//
//  MNGesturesLockDelegate.h
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

/**
 *  @class MNGesturesLockDelegate
 *  @brief 手势密码委托
 */
@protocol MNGesturesLockDelegate <NSObject>

@optional

/**
 *  手势轨迹绘制完成
 *
 *  @param gesturePassword <#gesturePassword description#>
 */
- (void)didGestureLockCompleted:(NSString *)gesturePassword;


/**
 *  手势密码错误
 *
 *  @param gesturePassword <#gesturePassword description#>
 */
- (void)afterGestureLockError:(NSString *)gesturePassword;

@end