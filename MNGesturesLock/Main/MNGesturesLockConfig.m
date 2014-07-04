//
//  MNGesturesLockConfig.m
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNGesturesLockConfig.h"

float const kDefaultX = .0f;
float const kDefaultY = 64.0f;
float const kDefaultWidth = 320.0f;
float const kDefaultHeight = 320.0f;
float const kDefaultDiameters = 80.0f;

@implementation MNGesturesLockConfig

+ (MNGesturesLockConfig *)defaults
{
    MNGesturesLockConfig *config = [[MNGesturesLockConfig alloc] init];
    config.frame = CGRectMake(kDefaultX, kDefaultY, kDefaultWidth, kDefaultHeight);
    config.bgColor = [UIColor clearColor];
    config.defaultPointImage = [config pointImageNormal];
    config.errorPointImage = [config pointImageError];
    config.touchedPointImage = [config pointImageTouched];
    config.pointTouchedColor = [UIColor colorWithRed:1.0f green:.84f blue:.37f alpha:.65f];
    config.pointErrorColor = [UIColor colorWithRed:1.0f green:.37f blue:.1f alpha:.65f];
    return config;
}

- (UIImage *)pointImageNormal
{
    return [UIImage imageNamed:@"MNGesturesPointNormal"];
}

- (UIImage *)pointImageError
{
    return [UIImage imageNamed:@"MNGesturesPointError"];
}

- (UIImage *)pointImageTouched
{
    return [UIImage imageNamed:@"MNGesturesPointTouched"];
}

@end
