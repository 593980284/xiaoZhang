//
//  MineListCell.m
//  xiaoZhang
//
//  Created by nick_beibei on 2018/12/8.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "MineListCell.h"
@interface MineListCell()
@property(nonatomic, strong)UILabel *titleLb ;
@end
@implementation MineListCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor *color = LineColor;
    [color set]; //设置线条颜色

    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [path moveToPoint:CGPointMake(0, rect.size.height - 1)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 1)];
    [path stroke];

    UIBezierPath *path2 = [UIBezierPath bezierPath];
    path2.lineWidth = 1;
    [path2 moveToPoint:CGPointMake(rect.size.width-15, 15)];
    [path2 addLineToPoint:CGPointMake(rect.size.width-10, 20)];
    [path2 moveToPoint:CGPointMake(rect.size.width-10, 20)];
    [path2 addLineToPoint:CGPointMake(rect.size.width-15, 25)];
    [path2 stroke];
}


-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        _titleLb = [UILabel new];
        _titleLb.text = title;
        [self addSubview:_titleLb];
        _titleLb.sd_layout
        .topSpaceToView(self, 5)
        .bottomSpaceToView(self, 5)
        .leftSpaceToView(self, 10*HC_750Ratio)
        .rightSpaceToView(self, 50);
        [self initData];
        
    }
    return self;
}

- (void)initData
{
    self.font = HC_750Font(10);
    self.textColor = TitleColor_333;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    _titleLb.font = font;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _titleLb.textColor = textColor;
}

@end
