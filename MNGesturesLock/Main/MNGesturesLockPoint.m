//
//  MNGesturesLockPoint.m
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNGesturesLockPoint.h"

@implementation MNGesturesLockPoint

- (instancetype)initWithID:(NSInteger)ID andX:(NSInteger)x andY:(NSInteger)y andDiameters:(NSUInteger)diameters
{
    if(self = [super init]) {
        self.ID = ID;
        self.nextID = ID;
        self.x = x;
        self.y = y;
        self.diameters = diameters;
    }
    return self;
}

- (BOOL)hasNextId
{
    return  _nextID != _ID;
}

- (NSInteger)getCenterX
{
    return self.x + self.diameters / 2;
}

- (NSInteger)getCenterY
{
    return self.y + self.diameters / 2;
}

- (BOOL)isInRange:(NSInteger)x y:(NSInteger)y
{
    NSInteger selfX = self.x;
    NSInteger selfY = self.y;
    NSUInteger diameters = self.diameters;
    BOOL inX = x > selfX && x < (selfX + diameters);
    BOOL inY = y > selfY && y < (selfY + diameters);
    return inX && inY;
}

@end
