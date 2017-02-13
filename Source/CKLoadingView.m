//
//  CKLoadingView.m
//  Strawberry
//
//  Created by Enix Yu on 11/2/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import "CKLoadingView.h"

#define CKLoadingDefaultItemCount               3
#define CKLoadingLayerHeightFactor              0.06
#define CKLoadingViewDefaultSpeed               0.8
#define CKLoadingViewDefaultStopWaitInterval    0.5
#define CKLoadingItemDelayInterval              0.5
#define CKLoadingAnimationAlpha                 1.0
#define CKLoadingItemMarginFactor               0.5
#define CKLoadingItemRectangleWidthFactor       0.3
#define CKLoadingViewAnimationIdentityKey       @"animationIndex"

@interface CKLoadingView ()

//
//  +---------+
//  |         |
//  |  O O O  |
//  |         |
//  +---------+
//

{
    /// For internal usage only
    CGFloat __itemWidth;
    CGFloat __itemHeight;
    CGFloat __itemMargin;
}

@property (nonatomic, copy)   NSMutableArray<CAShapeLayer *> *loadingLayers;
@property (nonatomic, assign) BOOL animationStop;

@end

@implementation CKLoadingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    _loadingShape = CKLoadingShapeCircle;
    _loadingColor = [UIColor lightGrayColor];
    _animationSpeed = CKLoadingViewDefaultSpeed;
    _loadingLayers = [NSMutableArray array];
    _animationStopWaitInterval = CKLoadingViewDefaultStopWaitInterval;
    _animationItemDelayInterval = _animationSpeed * CKLoadingItemDelayInterval;
    _animationStop = NO;
    _totalLoadingItems = CKLoadingDefaultItemCount;
    _animateToAlpha = CKLoadingAnimationAlpha;
    
    // item config
    __itemHeight = CGRectGetWidth(self.frame) * CKLoadingLayerHeightFactor;
    __itemWidth = CGRectGetWidth(self.frame) * CKLoadingLayerHeightFactor;
    __itemMargin = __itemWidth * CKLoadingItemMarginFactor;
    
    // Set to Max value when value not assigned
    _itemWidth = -1;
    _itemHeight = -1;
    _itemMargin = -1;
}

- (void)setLoadingShape:(CKLoadingShape)loadingShape {
    if (_loadingShape != loadingShape) {
        _loadingShape = loadingShape;
        
        if (_loadingShape == CKLoadingShapeRectangle) {
            self.itemWidth = __itemHeight * CKLoadingItemRectangleWidthFactor;
        }
    }
}

- (void)setItemWidth:(CGFloat)itemWidth {
    if (itemWidth != _itemWidth) {
        _itemWidth = itemWidth;
        __itemWidth = _itemWidth;
        
        // Recalculate the height and margin
        if (_itemHeight + 1 < 0.0001) {
            if (_loadingShape != CKLoadingShapeRectangle) {
                __itemHeight = __itemWidth;
            }
        }
        
        if (_itemMargin  + 1 < 0.0001) {
            __itemMargin = __itemWidth * CKLoadingItemMarginFactor;
        }
    }
}

- (void)setItemHeight:(CGFloat)itemHeight {
    if (itemHeight != _itemHeight) {
        _itemHeight = itemHeight;
        __itemHeight = itemHeight;
        
        // Recalculate the width and margin
        if (_itemWidth + 1 < 0.0001) {
            if (_loadingShape != CKLoadingShapeRectangle) {
                __itemWidth = itemHeight;
            }
        }
        
        if (_itemMargin + 1 < 0.0001) {
            __itemMargin = __itemWidth * CKLoadingItemMarginFactor;
        }
    }
}

- (void)setItemMargin:(CGFloat)itemMargin {
    if (_itemMargin != itemMargin) {
        _itemMargin = itemMargin;
        __itemMargin = itemMargin;
    }
}

- (void)resetShapeLayer {
    [self stopAnimate];

    for (int i = 0; i < [_loadingLayers count]; i++) {
        [[_loadingLayers objectAtIndex:i] removeFromSuperlayer];
    }

    for (int i = 0; i < _totalLoadingItems; i ++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path;
        CGFloat height = __itemHeight;
        CGFloat width = __itemWidth;
        
        if (_loadingShape == CKLoadingShapeSquare) {
            // Square
            path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
        } else if (_loadingShape == CKLoadingShapeRectangle) {
            // Rectangle
            path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
        } else if (_loadingShape == CKLoadingShapeCircle) {
            // Circle
            path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(height/2, height/2)
                                                  radius:height/2
                                              startAngle:0
                                                endAngle:2*M_PI
                                               clockwise:YES];
        }
        
        CGFloat x = (CGRectGetWidth(self.frame) - _totalLoadingItems * __itemWidth - (_totalLoadingItems - 1) * __itemMargin) / 2
                    + i * (__itemWidth + __itemMargin);
        CGFloat y = (CGRectGetHeight(self.frame) - __itemHeight) / 2;
        
        layer.fillColor = self.loadingColor.CGColor;
        layer.path = path.CGPath;
        layer.frame = CGRectMake(x, y, height, height);
        
        // Scale to zero size when initialized.
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        CATransform3D tr = CATransform3DIdentity;
        if (_loadingShape == CKLoadingShapeRectangle) {
            tr = CATransform3DMakeScale(1.0, 0, 1.0);
        } else {
            tr = CATransform3DMakeScale(0, 0, 1.0);
        }
        layer.transform = tr;
        [CATransaction commit];
        
        [_loadingLayers addObject:layer];
        [self.layer addSublayer:layer];
    }
}

- (void)startAnimate {
    if ([_loadingLayers count] == 0) {
        [self resetShapeLayer];
    }
    
    [self triggerAnimation];
}

- (void)stopAnimate {
    _animationStop = YES;
}

- (void)triggerAnimation {
    //
    // Set the animation delay time:
    // @see http://stackoverflow.com/questions/15116712/how-to-delay-a-cabasicanimation
    // And Core Animation Programming Guide:
    // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/AdvancedAnimationTricks/AdvancedAnimationTricks.html
    //
    
    _animationStop = NO;

    for (int i = 0; i < [_loadingLayers count]; i ++) {
        CAShapeLayer *layer = [_loadingLayers objectAtIndex:i];
        
        //////////////// Scale animation
        CABasicAnimation *resizeAnimate = [CABasicAnimation animationWithKeyPath:@"transform"];
        
        // Scale to the original size;
        CATransform3D tr = CATransform3DIdentity;
        tr = CATransform3DMakeScale(1.0, 1.0, 1.0);

        // Set an animation delay
        CFTimeInterval localLayerTime = [layer convertTime:CACurrentMediaTime() + self.animationItemDelayInterval * i fromLayer:nil];
        resizeAnimate.beginTime = localLayerTime;
        
        resizeAnimate.toValue = [NSValue valueWithCATransform3D:tr];
        resizeAnimate.duration = self.animationSpeed;
        resizeAnimate.autoreverses = YES;
        resizeAnimate.repeatCount = 1;
        
        if (i == [_loadingLayers count] - 1) {
            // How to identify animation within animationDidStop:finished:
            // @see: http://stackoverflow.com/questions/1255086/how-to-identify-caanimation-within-the-animationdidstop-delegate
            // [resizeAnimate setValue:@(i) forKey:CKLoadingViewAnimationIdentityKey];
            resizeAnimate.delegate = self;
        }
        
        [layer addAnimation:resizeAnimate forKey:resizeAnimate.keyPath];
        
        //////////////// Change alpha animation
        if (fabs(_animateToAlpha - 1.0) < 0.0001) {
            // _animateToAlpha is not changed, so no need to add animation
            continue;
        }

        CABasicAnimation *alphaAnimate = [CABasicAnimation animationWithKeyPath:@"opacity"];
        
        // Set an animation delay
        alphaAnimate.beginTime = localLayerTime;
        
        alphaAnimate.toValue = [NSNumber numberWithFloat:self.animateToAlpha];
        alphaAnimate.duration = self.animationSpeed;
        alphaAnimate.autoreverses = YES;
        alphaAnimate.repeatCount = 1;
        [layer addAnimation:alphaAnimate forKey:alphaAnimate.keyPath];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_animationStop) {
        return;
    }

    // Last animation is ended, so wait a specific time, and start another round of animation
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.animationStopWaitInterval * NSEC_PER_MSEC)),
                   dispatch_get_main_queue(), ^{
                       [self triggerAnimation];
                   });
}

@end
