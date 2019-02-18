//
//  TestQualityTableViewCell.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/13.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "TestQualityTableViewCell.h"

@implementation TestQualityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _lbs = [NSMutableArray new];
        for (int i = 0; i<5; i++) {
            UILabel *lb = [UILabel new];
            lb.hcTextBlock(i==4? HexColor(@"#FF8C05"): TitleColor_333, SystemFont(14),  1);
            [self.contentView addSubview:lb];
            CGFloat widthRatio = 0.9/4.0;
            if (i==0) {
                widthRatio = 0.1;
            }
            lb.sd_layout
            .widthRatioToView(self.contentView, widthRatio)
            .topSpaceToView(self.contentView, 0)
            .bottomSpaceToView(self.contentView, 0)
            .leftSpaceToView(_lbs.count>0 ? _lbs.lastObject : self.contentView, 0);
            [_lbs addObject:lb];
        }
    }
    return self;
}

- (void)setModel:(TestQualityModel *)model
{
    _model = model;
    _lbs[1].text = @[@"全部科目",@"科目一",@"科目二",@"科目三",@"安全文明"][model.subType];
    _lbs[2].text = NSStringFromInt(model.examNum);
    _lbs[3].text = NSStringFromInt(model.passNum);
    _lbs[4].text = [NSString stringWithFormat:@"%ld%%",model.passRate];
}

- (void)setNum:(NSString *)num
{
    _num = num;
    _lbs[0].text = num;
}
@end
