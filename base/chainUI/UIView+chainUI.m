//
//  UIView+chainUI.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/12.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "UIView+chainUI.h"
@implementation UIView (chainUI)


- (void)setHcTextBlock:(TextBlock)hcTextBlock
{
    objc_setAssociatedObject(self, @selector(hcTextBlock), hcTextBlock, OBJC_ASSOCIATION_COPY);
}

- (TextBlock)hcTextBlock
{
    TextBlock block =  objc_getAssociatedObject(self, _cmd);
    if (!block) {
        __weak typeof(self) weakSelf = self;
        self.hcTextBlock = ^UIView *(UIColor * _Nonnull textColor,
                                         UIFont* font,
                                         NSTextAlignment alignment) {
            if ([weakSelf isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel*) weakSelf;
                label.font = font;
                label.textColor = textColor;
                label.textAlignment = alignment;
            }
            return weakSelf;
        };
    }
    return  objc_getAssociatedObject(self, _cmd);;
}

- (void)setHcShadowBlock:(ShadowBlock)hcShadowBlock
{
    objc_setAssociatedObject(self, @selector(hcShadowBlock), hcShadowBlock, OBJC_ASSOCIATION_COPY);
}

- (ShadowBlock)hcShadowBlock
{
    ShadowBlock block =  objc_getAssociatedObject(self, _cmd);
    if (!block) {
        __weak typeof(self) weakSelf = self;
        self.hcShadowBlock = ^UIView *(UIColor * _Nonnull shadowColor,
                                       CGFloat shadowOpacity,
                                       CGFloat offsetX,
                                       CGFloat offsetY) {
            weakSelf.layer.shadowColor = shadowColor.CGColor;
            weakSelf.layer.shadowOpacity = shadowOpacity;
            weakSelf.layer.shadowOffset = CGSizeMake(offsetX, offsetY);
            return weakSelf;
        };
        
    }
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setHcBorderBlock:(BorderBlock)hcBorderBlock
{
    objc_setAssociatedObject(self, @selector(hcBorderBlock), hcBorderBlock, OBJC_ASSOCIATION_COPY);
}

- (BorderBlock)hcBorderBlock
{
    BorderBlock block =  objc_getAssociatedObject(self, _cmd);
    if (!block) {
        __weak typeof(self) weakSelf = self;

        self.hcBorderBlock = ^UIView *(UIColor * _Nonnull borderColor,
                                           CGFloat borderWidth,
                                           BOOL clipsToBounds) {
            weakSelf.layer.borderColor = borderColor.CGColor;
            weakSelf.layer.borderWidth = borderWidth;
            weakSelf.clipsToBounds = clipsToBounds;
            return weakSelf;
        };

    }
    return  objc_getAssociatedObject(self, _cmd);
}

@end
