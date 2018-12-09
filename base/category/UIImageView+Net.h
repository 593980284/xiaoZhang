//
//  UIImageView+Net.h
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Net)

/**
 1.如果imageString没有http，会拼接默认域名
 2.自带有默认图片
 */
- (void)setImageWithImageString:(NSString *)imageString;

/**
1.如果没有http，会拼接默认域名
2.默认图片需要自己设置
*/
- (void)setImageWithImageString:(NSString *)imageString placeholderString:(NSString *)placeholderString;
- (void)setImageWithImageString:(NSString *)imageString placeholder:(UIImage *)placeholder;
@end

