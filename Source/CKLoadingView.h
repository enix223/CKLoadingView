//
//  CKLoadingView.h
//  Strawberry
//
//  Created by Enix Yu on 11/2/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * The shape of the loading item
 */
typedef NS_ENUM(NSUInteger, CKLoadingShape) {
    // Square loading shape
    CKLoadingShapeSquare,
    
    // Rectangle loading shape
    CKLoadingShapeRectangle,
    
    // Circle loading shape
    CKLoadingShapeCircle,
};

/***************************************************************************************************************
 *
 *                     +------------ The animation speed `animationSpeed`
 *                     |
 *                     v      v----------------- The loading shape `loadingShape`
 * Loading Item1:   o    O    o                         o    O    o
 *                  |____|____|                         |____|____|
 * Loading Item2:           o    O    o                         o    O    o <-- Item width / height
 *                          |____|____|                         |____|____|
 * Loading Item3:                   o    O    o                         o    O    o
 *                                  |____|____|                         |____|____|
 *
 *                               ^  ^
 *                               ----
 *                                             *       *
 *                                 ^           =========  <----- The pause interval `animationStopWaitInterval`
 *                                 |
 *                                 +----- The loading item delay interval `animationItemDelayInterval`
 *
 * Timeline:        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *
 ****************************************************************************************************************/

/**
 * Fully customized animatable Loading view
 */
@interface CKLoadingView : UIView

/**
 * The shape of the loading item
 * For possible values, please @see CKLoadingShape
 */
@property (nonatomic, assign) CKLoadingShape loadingShape;

/**
 * The color of the loading item, `loadingColor` is default to [UIColor lightGrayColor]
 */
@property (nonatomic, strong) UIColor *loadingColor;

/**
 * The loading item animation speed (unit: second). Default to 0.8 second
 */
@property (nonatomic, assign) NSTimeInterval animationSpeed;

/**
 * The pause interval between two groups of animation (unit: second). Default to 0.5 second
 */
@property (nonatomic, assign) NSTimeInterval animationStopWaitInterval;

/**
 * The delay interval (unit: second) between two item's animation begin time.
 * Default to animationSpeed * 0.5 second
 */
@property (nonatomic, assign) NSTimeInterval animationItemDelayInterval;

/**
 * Total number of loading items. Default to 3.
 */
@property (nonatomic, assign) NSUInteger totalLoadingItems;

/**
 * The animation item width
 */
@property (nonatomic, assign) CGFloat itemWidth;

/**
 * The animation item height
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 * The animation item margin
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 * The loading item animation ending alpha value. Should be in range of (0, 1].
 * @note If animateToAlpha = 0, then will cause the loading item blinking.
 */
@property (nonatomic, assign) CGFloat animateToAlpha;

/**
 * Start to loading animation.
 *
 * @note After calling startAnimate: method, all the properties changes will not
 * affect the loading animation behaviour. So be sure to change the desired properties before 
 * calling startAnimate:
 */
- (void)startAnimate;

/**
 * Stop loading animation.
 *
 * @note When calling stopAnimate: method, the loading animation will
 * not immediately stop, it will wait until all the item animation finished in the current 
 * animation group.
 */
- (void)stopAnimate;

@end
