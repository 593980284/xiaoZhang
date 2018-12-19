//
//  MineView.m
//  xiaoZhang
//
//  Created by nick_beibei on 2018/12/19.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "MineView.h"
#import "MineListCell.h"

@implementation MineView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    UIColor *color = LineColor;
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    path.lineCapStyle = kCGLineCapRound;
    
    [path moveToPoint:(CGPoint){0, rect.size.height-1}];
    [path addLineToPoint:(CGPoint){0,0}];
    [path addLineToPoint:(CGPoint){rect.size.width,0}];
    [path addLineToPoint:(CGPoint){rect.size.width, rect.size.height-1}];
    [path stroke];
}

- (instancetype)initWithCellArray:(NSArray *)cellArray withCellHeight:(CGFloat)cellHeight {
    self = [super init];
    if(self) {
        for (int i = 0; i<cellArray.count; i++) {
            MineListCell *cell = [[MineListCell alloc]initWithTitle:cellArray[i]];
            cell.backgroundColor = [UIColor whiteColor];
            [self addSubview:cell];
            cell.sd_layout
            .topSpaceToView(self, i*cellHeight*HC_320Ratio)
            .leftSpaceToView(self, 1*HC_320Ratio)
            .rightSpaceToView(self, 1*HC_320Ratio)
            .heightIs(cellHeight*HC_320Ratio);
        }
    }
    return self;
}

@end
