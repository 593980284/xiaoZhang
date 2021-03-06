//
//  BaseVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/27.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "BaseVC.h"
//#import <UIViewController+GKCategory.h>
@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    if (HC_systemVersion < 11) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // Do any additional setup after loading the view.
}
/** 横竖屏幕 ***********************************************/
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (void)setInteractivePopDisabled:(BOOL)interactivePopDisabled
{
    self.gk_interactivePopDisabled = interactivePopDisabled;
}
/* **********************************************/
- (BOOL)interactivePopDisabled
{
    return self.gk_interactivePopDisabled;
}

- (void)setNavBarAlpha:(CGFloat)navBarAlpha
{
    self.gk_navBarAlpha = navBarAlpha;
}

- (CGFloat)navBarAlpha
{
    return self.gk_navBarAlpha;
}

- (void)setPopMaxAllowedDistanceToLeftEdge:(CGFloat)popMaxAllowedDistanceToLeftEdge
{
    self.gk_popMaxAllowedDistanceToLeftEdge = popMaxAllowedDistanceToLeftEdge;
}

- (CGFloat)popMaxAllowedDistanceToLeftEdge
{
  return self.gk_popMaxAllowedDistanceToLeftEdge;
}

- (void)setFullScreenPopDisabled:(BOOL)fullScreenPopDisabled
{
    self.gk_fullScreenPopDisabled = fullScreenPopDisabled;
}

- (BOOL)fullScreenPopDisabled
{
    return self.gk_fullScreenPopDisabled;
}

@end
