//
//  MNGesturesLockView.m
//  MNGesturesLock
//
//  Created by 陆广庆 on 14/7/5.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNGesturesLockView.h"
#import "MNGesturesLockConfig.h"
#import "MNGesturesLockPoint.h"
#import "MNGesturesLockDelegate.h"

typedef NS_ENUM(NSInteger, MNGesturesState)
{
    MNGesturesStateNormal,
    MNGesturesStateError
};

@interface MNGesturesLockView()

@property (nonatomic, assign) CGContextRef ref;
@property (nonatomic, assign) MNGesturesState state;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) MNGesturesLockConfig *config;
@property (nonatomic, strong) NSMutableString *password;
@property (nonatomic, assign) NSInteger lineX;
@property (nonatomic, assign) NSInteger lineY;
@property (nonatomic, strong) UIImage *defaultPointImage;
@property (nonatomic, strong) UIImage *touchedPointImage;
@property (nonatomic, strong) UIImage *errorPointImage;

@end

@implementation MNGesturesLockView

- (instancetype)initWithConfig:(MNGesturesLockConfig *)config
{
    if (self = [super init]) {
        //init config
        if(config == nil) {
            config = [MNGesturesLockConfig defaults];
        }
        self.config = config;
        self.frame = config.frame;
        self.backgroundColor = config.bgColor;
        self.defaultPointImage = config.defaultPointImage;
        self.errorPointImage = config.errorPointImage;
        self.touchedPointImage = config.touchedPointImage;
        //self properties
        self.state = MNGesturesStateNormal;
        self.lineX = self.lineY = -1;
        [self initPoints];
    }
    return self;
}

#pragma mark -UIView method
- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(ref, YES);
    CGContextSetLineWidth(ref, 10);
    CGColorRef color;
    if(self.state == MNGesturesStateError) {
        color = self.config.pointErrorColor.CGColor;
    } else {
        color = self.config.pointTouchedColor.CGColor;
    }
    const CGFloat *components = CGColorGetComponents(color);
    CGContextSetRGBStrokeColor(ref, components[0], components[1], components[2], components[3]);
    self.ref = ref;
    [self drawSelf];
}

#pragma mark -Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.password = [NSMutableString stringWithCapacity:9];
    CGPoint point = [[touches anyObject] locationInView:self];
    BOOL inRange = NO;
    for (MNGesturesLockPoint *p in self.points) {
        if ([p isInRange:point.x y:point.y]) {
            p.touchPass = YES;
            [self.password appendFormat:@"%ld",(long)p.ID];
            inRange = YES;
            break;
        }
    }
    if (!inRange)
        return;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    self.lineX = point.x;
    self.lineY = point.y;
    for(MNGesturesLockPoint *p in self.points) {
        if([p isInRange:point.x y:point.y] && !p.touchPass) {
            p.touchPass = YES;
            if([self.password length] > 0) {
                int preId = [self.password characterAtIndex:[self.password length] - 1] - 48;
                [self.points[preId] setNextID:p.ID];
            }
            [self.password appendFormat:@"%ld",(long)p.ID];
            break;
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if([self.password length] == 0)
        return;
    [self resetPoints];
    [self setNeedsDisplay];
    if([self.delegate respondsToSelector:@selector(didGesturesPasswordCompleted:)])
        [self.delegate didGesturesPasswordCompleted:self.password];
}

#pragma mark -private method
/**
 *  @brief 初始化圆点
 */
- (void)initPoints
{
    self.points = [NSMutableArray arrayWithCapacity:9];
    NSUInteger diameters;
    if (self.defaultPointImage != nil) {
        diameters = self.defaultPointImage.size.width;
    } else {
        diameters = kDefaultDiameters;
    }
    int spacing = (self.bounds.size.width - diameters * 3) / 4;
    int startX = spacing;
    int startY = 0;
    for (int i = 0; i < 9; i++) {
        if(i == 3 || i == 6) {
            startX = spacing;
            startY += diameters + spacing;
        }
        MNGesturesLockPoint *point = [[MNGesturesLockPoint alloc] initWithID:i andX:startX andY:startY andDiameters:diameters];
        [self.points addObject:point];
        startX += diameters + spacing;
    }
}


- (void)drawSelf
{
    if ([self.password length] > 0) {
        int startPointId = [self.password characterAtIndex:0] - 48;
        MNGesturesLockPoint *start = self.points[startPointId];
        while ([start hasNextId]) {
            MNGesturesLockPoint *next = self.points[start.nextID];
            [self drawLine:[start getCenterX] startY:[start getCenterY] endX:[next getCenterX] endY:[next getCenterY]];
            start = next;
        }
        if (self.lineX != -1 && self.lineY != -1) {
            [self drawLine:[start getCenterX] startY:[start getCenterY] endX:self.lineX endY:self.lineY];
        }
    }
    for (MNGesturesLockPoint *p in self.points) {
        [self.defaultPointImage drawAtPoint:CGPointMake(p.x, p.y)];
        if (p.touchError) {
            [self.errorPointImage drawAtPoint:CGPointMake(p.x, p.y)];
        } else if (p.touchPass) {
            [self.touchedPointImage drawAtPoint:CGPointMake(p.x, p.y)];
        }
    }
}

- (void)drawLine:(NSInteger)startX startY:(NSInteger)startY endX:(NSInteger)endX endY:(NSInteger)endY
{
    CGContextMoveToPoint(self.ref, startX, startY);
    CGContextAddLineToPoint(self.ref, endX, endY);
    CGContextStrokePath(self.ref);
}

- (void)resetPoints
{
    for (MNGesturesLockPoint *p in self.points) {
        p.touchPass = NO;
        p.touchError = NO;
        p.nextID = p.ID;
    }
    self.lineX = self.lineY = -1;
    self.state = MNGesturesStateNormal;
}

- (void)passwordErrored
{
    self.userInteractionEnabled = NO;
    self.state = MNGesturesStateError;
    NSUInteger length = [self.password length];
    for (int i=0;i<length;i++) {
        NSInteger ID = [self.password characterAtIndex:i] - 48;
        [self.points[ID] setTouchError:YES];
        if(i + 1 < [self.password length]) {
            [self.points[ID] setNextID:[self.password characterAtIndex:i + 1] - 48];
        }
    }
    [self setNeedsDisplay];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(drawErrorCompleted:)userInfo:nil repeats:NO];
}

- (void)drawErrorCompleted:(NSTimer *)timer
{
    [self resetPoints];
    [self setNeedsDisplay];
    self.userInteractionEnabled = YES;
}


@end
