//
//  UIImageView+Net.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Net)
- (void)setImageWithImageString:(NSString *)imageString;
- (void)setImageWithImageString:(NSString *)imageString placeholderString:(NSString *)placeholderString;
- (void)setImageWithImageString:(NSString *)imageString placeholder:(UIImage *)placeholder;
@end

