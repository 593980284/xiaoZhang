//
//  HomeFormView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/6.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "HomeFormView.h"
@interface HomeFormView()
@property(nonatomic, strong)NSMutableArray<UILabel *> *lables;
@end
@implementation HomeFormView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        
        self.lables = [NSMutableArray new];
        self.backgroundColor = [UIColor whiteColor];
        self.hcCornerRadiusBlock(7, YES);
        self.hcTapBlock(self, @selector(tap:));
        
        UILabel *titleLb = [UILabel new];
        titleLb.hcTextBlock(BlueColor, [UIFont systemFontOfSize:12], 1)
        .hcBorderBlock(BlueColor, 1)
        .hcCornerRadiusBlock(7, YES);
        titleLb.text = title;
        
        [self addSubview:titleLb];
        
        titleLb.sd_layout
        .topSpaceToView(self, 16)
        .leftSpaceToView(self, 10)
        .heightIs(24)
        .widthIs(55);
        
        NSArray *array = @[@"报名人数", @"在线约考", @"在线约课/取消人数", @"考试人数/合格人数"];
        for (int i = 0; i < array.count; i++) {
            UILabel * subTitleLb = [UILabel new];
            subTitleLb.text = array[i];
            subTitleLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:12], 0);
            
            UILabel *valueLb = [UILabel new];
            if (i == 0) {
                  valueLb.hcTextBlock([UIColor colorWithHexString:@"FF8C05"], [UIFont systemFontOfSize:27], 2);
            }else{
                  valueLb.hcTextBlock(TitleColor_333, [UIFont fontWithName:@"SourceHanSansCN-Heavy" size: 14], 2);
            }
            
            UIImageView *arrowImgView = [UIImageView new];
            arrowImgView.hcImageBlock(@"right_arrow");
            
            [self sd_addSubviews:@[subTitleLb, valueLb, arrowImgView]];
            
            subTitleLb.sd_layout
            .topSpaceToView(titleLb, 10 + i * 40)
            .leftSpaceToView(self, 16)
            .heightIs(40);
            [subTitleLb setSingleLineAutoResizeWithMaxWidth:300];
            
            arrowImgView.sd_layout
            .centerYEqualToView(subTitleLb)
            .heightIs(17)
            .widthIs(17)
            .rightSpaceToView(self, 15);
            
            valueLb.sd_layout
            .rightSpaceToView(arrowImgView, 15)
            .heightIs(40)
            .leftSpaceToView(subTitleLb, 0)
            .centerYEqualToView(subTitleLb);
            
            [self.lables addObject:valueLb];
            
            if (i + 1 == array.count) {
                [self setupAutoHeightWithBottomView:subTitleLb bottomMargin:0];
            }
        }
    }
    return self;
}

- (void)setValues:(NSArray *)values
{
    _values = values;
    for (int i = 0; i<values.count && i< self.lables.count; i++) {
        self.lables[i].text = values[i];
    }
}

/// 根据点击点的y坐标 减去title标签的 高度 50。除以每行40高，计算点击第几行
- (void)tap:(UITapGestureRecognizer *)gr
{
    CGFloat y = [gr locationInView:self].y - 50;
    if (y > 0 && self.tapBlock) {
        self.tapBlock(y/40);
    }
}

@end
