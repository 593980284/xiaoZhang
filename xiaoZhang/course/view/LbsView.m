//
//  LbsView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/12.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "LbsView.h"
@interface LbsView()
@property(nonatomic, strong)NSMutableArray<UIButton *> *btns;
@end
@implementation LbsView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (NSMutableArray<UIButton *>*)btns
{
    if (!_btns) {
        _btns = [NSMutableArray new];
    }
    
    return _btns;
}

- (void)setData:(NSArray<CourseEvaluation_listModel *> *)data
{
    _data = data;
    [self removeAllSubviews];
    [self.btns removeAllObjects];
    for (CourseEvaluation_listModel *model in data) {
        UIButton *btn = [UIButton new];
        btn.hcNomalTextBlock(DetialColor_666, model.labelName, SystemFont(14))
        .hcBorderBlock(DetialColor_666, 1)
        .hcCornerRadiusBlock(5, YES);
        
        [btn setTitleColor:HexColor(@"#FF8C05") forState:UIControlStateSelected];
        NSInteger index = [data indexOfObject:model];
        NSInteger row = index/3;
        NSInteger line = index%3;
        [self addSubview:btn];
        btn.sd_layout
        .topSpaceToView(self, 38*row)
        .leftSpaceToView(self, 94*line)
        .widthIs(85)
        .heightIs(30);
        
        [_btns addObject:btn];
    }
    if (_btns.count > 0) {
        [self setupAutoHeightWithBottomView:_btns.lastObject bottomMargin:0];
        [self setupAutoWidthWithRightView:_btns.lastObject rightMargin:0];
    }
}

- (void)setCoachLabel:(NSString *)coachLabel
{
    _coachLabel = coachLabel;
    NSArray *arr = [coachLabel componentsSeparatedByString:@","];
    for (NSString * lb in arr) {
        for (int i = 0; i< _data.count; i++) {
            if ([lb isEqualToString:_data[i].index]) {
                self.btns[i].selected = YES;
                _btns[i].layer.borderColor = HexColor(@"#FF8C05").CGColor;
            }else{
                _btns[i].selected = NO;
                _btns[i].layer.borderColor = DetialColor_666.CGColor;
            }
        }
    }
}

@end
