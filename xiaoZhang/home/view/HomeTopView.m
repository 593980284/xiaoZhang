//
//  HomeTopView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/30.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "HomeTopView.h"
@interface HomeTopView()
@property(nonatomic, strong)NSMutableArray<UILabel *> *lables;
@end
@implementation HomeTopView
-(instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super init]) {
        _lables = [NSMutableArray new];
        self.backgroundColor = [UIColor whiteColor];
        self.hcCornerRadiusBlock(5, YES);
        for (int i = 0; i < titles.count; i++) {
            UILabel *valueLb = [UILabel new];
            valueLb.hcTextBlock(BlueColor, [UIFont systemFontOfSize:20], 1);
            
            UILabel *titleLb = [UILabel new];
            titleLb.text = titles[i];
            titleLb.hcTextBlock(DetialColor_666, [UIFont systemFontOfSize:12], 1);
            
            [self sd_addSubviews:@[valueLb, titleLb]];
            valueLb.sd_layout
            .widthRatioToView(self, 1/(titles.count * 1.0))
            .heightIs(20)
            .centerYEqualToView(self).offset(-10)
            .leftSpaceToView(_lables.count == 0?self: _lables.lastObject, 0);
            [_lables addObject:valueLb];
            
            titleLb.sd_layout
            .leftEqualToView(valueLb)
            .heightIs(20)
            .rightEqualToView(valueLb)
            .topSpaceToView(valueLb, 0);
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

@end
