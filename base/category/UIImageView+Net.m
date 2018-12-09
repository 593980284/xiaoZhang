//
//  UIImageView+Net.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "UIImageView+Net.h"

@implementation UIImageView (Net)
- (void)setImageWithImageString:(NSString *)imageString
{
    [self setImageWithImageString:imageString placeholder:PlaceholderImage];
}

- (void)setImageWithImageString:(NSString *)imageString placeholderString:(NSString *)placeholderString
{
    [self setImageWithImageString:imageString placeholder:[UIImage imageNamed:placeholderString]];
}

- (void)setImageWithImageString:(NSString *)imageString placeholder:(UIImage *)placeholder{
    if (imageString.length > 0 == NO) {
        return;
    }
    if ([imageString hasPrefix:@"http"] == NO) {//如果不带http的
        imageString = [NSString stringWithFormat:@"%@%@",kBaseImageUrl, imageString];
    }
    //UTF8转一下，这样可以支持画url为中文的
    imageString = [imageString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self setImageWithURL:[NSURL URLWithString:imageString] placeholder:placeholder];
}
@end
