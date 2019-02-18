//
//  RegisterNumTableViewCell.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/13.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "RegisterNumTableViewCell.h"

@implementation RegisterNumTableViewCell

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
        for (int i = 0; i<3; i++) {
            UILabel *lb = [UILabel new];
            lb.hcTextBlock(TitleColor_333, SystemFont(14),  0);
            [self.contentView addSubview:lb];
            CGFloat widthRatio = 0.6/2;
            if (i==0) {
                widthRatio = 0.4;
            }
            lb.sd_layout
            .widthRatioToView(self.contentView, widthRatio)
            .topSpaceToView(self.contentView, 0)
            .bottomSpaceToView(self.contentView, 0)
            .leftSpaceToView(_lbs.count>0 ? _lbs.lastObject : self.contentView, _lbs.count>0?0:20);
            [_lbs addObject:lb];
        }
    }
    return self;
}

- (void)setModel:(RegisterNumTable_rowsModel *)model
{
    _model = model;
    _lbs[0].text = model.studentName;
    _lbs[1].text = model.signUpType.isEmpty? @"线下": model.signUpType ;
    _lbs[2].text = model.signUpDate;
}

@end
