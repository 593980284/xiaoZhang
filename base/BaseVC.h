//
//  BaseVC.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/27.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIViewController+GKCategory.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController
/** 是否禁止当前控制器的滑动返回(包括全屏返回和边缘返回) */
@property (nonatomic, assign) BOOL interactivePopDisabled;

/** 是否禁止当前控制器的全屏滑动返回 */
@property (nonatomic, assign) BOOL fullScreenPopDisabled;

/** 全屏滑动时，滑动区域距离屏幕左边的最大位置，默认是0，表示全屏都可滑动 */
@property (nonatomic, assign) CGFloat popMaxAllowedDistanceToLeftEdge;

/** 设置导航栏的透明度 */
@property (nonatomic, assign) CGFloat navBarAlpha;

@property (nonatomic, strong)UIColor *titleColor;
//
//// 自定义返回item
//- (UIBarButtonItem *)gk_customBackItemWithTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
