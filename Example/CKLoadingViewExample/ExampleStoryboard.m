//
//  ExampleStoryboard.m
//  CKLoadingViewExample
//
//  Created by Enix Yu on 13/2/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//
#import <CKLoadingView.h>
#import "ExampleStoryboard.h"

@interface ExampleStoryboard ()

@property (weak, nonatomic) IBOutlet CKLoadingView *circleLoadingView;
@property (weak, nonatomic) IBOutlet CKLoadingView *rectLoadingView;
@property (weak, nonatomic) IBOutlet CKLoadingView *squareLoadingView;


@end

@implementation ExampleStoryboard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /////////// Circle loading view ///////////////////////
    
    // The signle loading item's width
    _circleLoadingView.itemWidth = 20;
    
    // The margin between two loading item
    _circleLoadingView.itemMargin = _circleLoadingView.itemWidth * 0.3;
    
    // The animation speed (unit: second)
    _circleLoadingView.animationSpeed = 0.8;
    
    // The loading item's shape
    _circleLoadingView.loadingShape = CKLoadingShapeCircle;
    
    // The loading items's color
    _circleLoadingView.loadingColor = [UIColor colorWithRed:.8 green:.34 blue:.31 alpha:1];
    
    // Wait for 2.0 seconds when one group of animation finished
    _circleLoadingView.animationStopWaitInterval = 2.0;
    
    // The succeeding loading item animation will be began with `_circleLoadingView.animationSpeed * 0.3` seconds
    // after the proceeding loading item animation began.
    _circleLoadingView.animationItemDelayInterval = _circleLoadingView.animationSpeed * 0.3;
    
    // The loading item's target alpha value when animation end. Please note the animation will be reverse back,
    // so the alpha animation will be:  1.0 ----> 0.3 ---> 1.0
    _circleLoadingView.animateToAlpha = 1.0;
    
    /////////// Rectangle loading view ///////////////////////
    _rectLoadingView.itemWidth = 20;
    _rectLoadingView.itemMargin = _rectLoadingView.itemWidth * 0.3;
    _rectLoadingView.animationSpeed = 0.8;
    _rectLoadingView.animationStopWaitInterval = 2.0;
    _rectLoadingView.animationItemDelayInterval = _rectLoadingView.animationSpeed * 0.3;
    _rectLoadingView.loadingShape = CKLoadingShapeRectangle;
    _rectLoadingView.loadingColor = [UIColor colorWithRed:.37 green:.56 blue:.62 alpha:1];
    
    /////////// Square loading view ///////////////////////
    _squareLoadingView.itemWidth = 20;
    _squareLoadingView.itemMargin = _squareLoadingView.itemWidth * 0.3;
    _squareLoadingView.animationSpeed = 0.8;
    _squareLoadingView.animationStopWaitInterval = 2.0;
    _squareLoadingView.animationItemDelayInterval = _squareLoadingView.animationSpeed * 0.3;
    _squareLoadingView.loadingShape = CKLoadingShapeSquare;
    _squareLoadingView.loadingColor = [UIColor colorWithRed:.90 green:.73 blue:.29 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Trigger loading view to start animation
    [_circleLoadingView startAnimate];
    [_rectLoadingView startAnimate];
    [_squareLoadingView startAnimate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Stop animation
    [_circleLoadingView stopAnimate];
    [_squareLoadingView stopAnimate];
    [_rectLoadingView stopAnimate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
