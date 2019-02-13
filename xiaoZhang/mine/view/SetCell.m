//
//  SetCell.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/25.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        UILabel *titleLb = [UILabel new];
        titleLb.text = title;
        titleLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:14], 0);
        
         UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_arrow"]];
        
        [self sd_addSubviews:@[titleLb, arrowView]];
        
        titleLb.sd_layout
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .leftSpaceToView(self, 15)
        .widthIs(200);
        
        arrowView.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self, 15)
        .heightIs(12)
        .widthIs(12);
        
        UIView *line = [UIView new];
        line.backgroundColor = LineColor;
        [self addSubview:line];
        line.sd_layout
        .bottomSpaceToView(self, 0)
        .leftSpaceToView(self, 15)
        .rightSpaceToView(self, 15)
        .heightIs(0.5);
        
    }
    return self;
}

@end
