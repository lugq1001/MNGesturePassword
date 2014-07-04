//
//  MNGesturesLockConfig.h
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//
@import UIKit;

extern float const kDefaultX;
extern float const kDefaultY;
extern float const kDefaultWidth;
extern float const kDefaultHeight;
extern float const kDefaultDiameters;

/**
 *  @class MNGesturesLockConfig
 *  @note  手势密码配置类
 */
@interface MNGesturesLockConfig : NSObject

@property (nonatomic, assign) CGRect frame;

/**
 *  @brief 背景颜色
 */
@property (nonatomic, strong) UIColor *bgColor;

/**
 *  @brief 圆点图片
 */
@property (nonatomic, strong) UIImage *defaultPointImage;
@property (nonatomic, strong) UIImage *touchedPointImage;
@property (nonatomic, strong) UIImage *errorPointImage;
/**
 *  @brief 手势轨迹颜色
 */
@property (nonatomic, strong) UIColor *pointTouchedColor;
@property (nonatomic, strong) UIColor *pointErrorColor;


/**
 *  默认配置
 *
 *  @return GesturesLockConfig
 */
+ (MNGesturesLockConfig *)defaults;


@end
