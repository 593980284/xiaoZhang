//
//  MineListItem.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/23.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "MineListItem.h"

@implementation MineListItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithImageStr:(NSString *)imageStr
                           title:(NSString *)title
                          target:(id)target
                             sel:(SEL)sel
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageStr]];
        
        UILabel *titleLb = [UILabel new];
        titleLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:14], 0);
        titleLb.text = title;
        
        UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right_arrow"]];
        
        [self sd_addSubviews:@[imgView, titleLb, arrowView]];
        
        imgView.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 15)
        .heightIs(21)
        .widthIs(21);
        
        arrowView.sd_layout
        .centerYEqualToView(self)
        .rightSpaceToView(self, 15)
        .heightIs(12)
        .widthIs(12);
        
        titleLb.sd_layout
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .leftSpaceToView(imgView, 8)
        .rightSpaceToView(arrowView, 0);
        
        self.hcTapBlock(target, sel);
        
        
        UIView *line = [UIView new];
        line.backgroundColor = LineColor;
        [self addSubview:line];
        line.sd_layout
        .bottomSpaceToView(self, 0)
        .leftSpaceToView(self, 40)
        .rightSpaceToView(self, 15)
        .heightIs(0.5);
        
    }
    return self;
}

@end
