//
//  ExampleProgrammatic.m
//  CKLoadingViewExample
//
//  Created by Enix Yu on 13/2/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import "ExampleProgrammatic.h"
#import <CKLoadingView.h>

@interface ExampleProgrammatic ()

@property (nonatomic) CKLoadingView *circleLoadingView;
@property (nonatomic) CKLoadingView *rectLoadingView;
@property (nonatomic) CKLoadingView *squareLoadingView;

@end

@implementation ExampleProgrammatic

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat height = (CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(self.tabBarController.tabBar.bounds)) / 3;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //////////////////////// Circle loading view ///////////////////////
    _circleLoadingView = [[CKLoadingView alloc] initWithFrame:CGRectMake(0, statusBarHeight, CGRectGetWidth([UIScreen mainScreen].bounds), height)];
    // The signle loading item's width
    _circleLoadingView.itemWidth = 20;
    
    // The margin between two loading item
    _circleLoadingView.itemMargin = _circleLoadingView.itemWidth * 0.3;
    
    // The animation speed (unit: ms)
    _circleLoadingView.animationSpeed = 0.5;
    
    // The loading item's shape
    _circleLoadingView.loadingShape = CKLoadingShapeCircle;
    
    // The loading items's color
    _circleLoadingView.loadingColor = [UIColor colorWithRed:.8 green:.34 blue:.31 alpha:1];
    [self.view addSubview:_circleLoadingView];
    
    /////////////////////// Rectangle loading view ///////////////////////
    _rectLoadingView = [[CKLoadingView alloc] initWithFrame:CGRectMake(0, statusBarHeight + height, CGRectGetWidth([UIScreen mainScreen].bounds), height)];
    _rectLoadingView.itemWidth = 20;
    _rectLoadingView.itemMargin = _rectLoadingView.itemWidth * 0.3;
    _rectLoadingView.animationSpeed = 0.5;
    _rectLoadingView.loadingShape = CKLoadingShapeRectangle;
    _rectLoadingView.loadingColor = [UIColor colorWithRed:.37 green:.56 blue:.62 alpha:1];
    [self.view addSubview:_rectLoadingView];
    
    /////////////////////// Square loading view ///////////////////////
    _squareLoadingView = [[CKLoadingView alloc] initWithFrame:CGRectMake(0, statusBarHeight + 2 * height, CGRectGetWidth([UIScreen mainScreen].bounds), height)];
    _squareLoadingView.itemWidth = 20;
    _squareLoadingView.itemMargin = _squareLoadingView.itemWidth * 0.3;
    _squareLoadingView.animationSpeed = 0.5;
    _squareLoadingView.loadingShape = CKLoadingShapeSquare;
    _squareLoadingView.loadingColor = [UIColor colorWithRed:.90 green:.73 blue:.29 alpha:1];
    [self.view addSubview:_squareLoadingView];
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
