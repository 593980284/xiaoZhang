//
//  UIView+chainUI.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/12.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef UIView *(^ShadowBlock)(UIColor *shadowColor, CGFloat shadowOpacity, CGFloat offsetX, CGFloat offsetY);
typedef UIView *(^TextBlock)(UIColor *textColor, UIFont *font, NSTextAlignment alignment);
typedef UIView *(^BorderBlock)(UIColor *borderColor, CGFloat borderWidth, BOOL clipsToBounds);
@interface UIView (chainUI)
/** 设置阴影 */
@property(nonatomic, copy) ShadowBlock hcShadowBlock;
/** 设置text */
@property(nonatomic, copy) TextBlock hcTextBlock;
/** 设置边框 */
@property(nonatomic, copy) BorderBlock hcBorderBlock;
@end

NS_ASSUME_NONNULL_END
