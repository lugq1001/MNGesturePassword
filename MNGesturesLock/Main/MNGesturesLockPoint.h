//
//  MNGesturesLockPoint.h
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;

/**
 * @class GestureLockPoint
 * @note  手势密码圆点
 */
@interface MNGesturesLockPoint : NSObject

/**
 *  @brief 圆点id
 *  @note  记录操作顺序
 */
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger nextID;

/**
 *  @brief 圆点起始坐标
 */
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

/**
 *  @brief 圆点直径
 */
@property (nonatomic, assign) NSUInteger diameters;

/**
 *  @brief 圆点自身状态，用于重绘
 *  @note  touchPass-重绘手势经过该圆点的样式 touchError-重绘密码错误的样式
 */
@property (nonatomic) BOOL touchPass;
@property (nonatomic) BOOL touchError;

- (instancetype)initWithID:(NSInteger)ID andX:(NSInteger)x andY:(NSInteger)y andDiameters:(NSUInteger)diameters;

/**
 *  @brief 用于判断是否为手势选中的最后圆点
 *
 *  @return BOOL
 */
- (BOOL)hasNextId;

/**
 *  @brief 获得圆点圆心坐标x y
 *
 *  @return NSInteger
 */
- (NSInteger)getCenterX;
- (NSInteger)getCenterY;

/**
 *  @brief 判断当前坐标是否在圆内
 *
 *  @param x 坐标x
 *  @param y 坐标y
 *
 *  @return BOOL
 */
- (BOOL)isInRange:(NSInteger)x y:(NSInteger)y;


@end
