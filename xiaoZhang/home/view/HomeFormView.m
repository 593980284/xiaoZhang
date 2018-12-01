//
//  HomeFormView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/12/1.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "HomeFormView.h"

@implementation HomeFormView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderColor = LineColor.CGColor;
    self.layer.borderWidth = LineHeight;
    _line1.backgroundColor = LineColor;
    _line2.backgroundColor = LineColor;
    _line3.backgroundColor = LineColor;
    _line4.backgroundColor = LineColor;
    
}

- (instancetype)initWithFrame:(CGRect)frame
    {
        if (self = [super initWithFrame:frame]) {
            self= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]lastObject];
        }
        return self;
    }


@end
