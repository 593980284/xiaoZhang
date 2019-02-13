//
//  StudentTableViewCell.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/11.
//  Copyright © 2019年 胡胡超. All rights reserved.
// height 100， top 5  中 93  bottom 2

#import "StudentTableViewCell.h"
@interface StudentTableViewCell()
@property(nonatomic, strong)UIImageView *headImgView;
@property(nonatomic, strong)UIImageView *sexImgView;
@property(nonatomic, strong)UILabel *nameLb;
@property(nonatomic, strong)UILabel *subjectNameLb;
@property(nonatomic, strong)UIButton *btn;

@end
@implementation StudentTableViewCell

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
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.shadowRadius = 2;
        bgView.hcCornerRadiusBlock(5, YES)
        .hcShadowBlock([UIColor blackColor], 0.3, 0, 0);
        [self.contentView addSubview:bgView];
        bgView.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(5, 15, 2, 15));
        
        _headImgView = [UIImageView new];
        _sexImgView = [UIImageView new];
        
        
        _nameLb = [UILabel new];
        _nameLb.hcTextBlock(TitleColor_333, Font(16, 14), 0);
        
        _subjectNameLb = [UILabel new];
        _subjectNameLb.hcTextBlock(DetialColor_666, SystemFont(12), 0);
        
        _btn = [UIButton new];
        _btn.hcNomalTextBlock(HexColor(@"FFFFFF"), @"查看评价", SystemFont(12))
        .hcDisabledTextBlock(HexColor(@"FFFFFF"), @"未评价", SystemFont(12))
        .hcCornerRadiusBlock(5, YES)
        .hcTapBlock(self, @selector(btnTap:));
        
        [bgView sd_addSubviews:@[_headImgView, _sexImgView, _nameLb, _subjectNameLb, _btn]];
        
        _headImgView.sd_layout
        .topSpaceToView(bgView, 8)
        .leftSpaceToView(bgView, 10)
        .heightIs(70)
        .widthIs(70);
        
        _sexImgView.sd_layout
        .rightEqualToView(_headImgView)
        .bottomEqualToView(_headImgView)
        .heightIs(25)
        .widthIs(25);
        
        _nameLb.sd_layout
        .topEqualToView(_headImgView)
        .leftSpaceToView(_headImgView, 12)
        .rightSpaceToView(bgView, 0)
        .heightIs(20);
        
        _subjectNameLb.sd_layout
        .heightIs(15)
        .leftEqualToView(_nameLb)
        .bottomEqualToView(_headImgView);
        [_subjectNameLb setSingleLineAutoResizeWithMaxWidth:300];
        
        _btn.sd_layout
        .rightSpaceToView(bgView, 12)
        .heightIs(30)
        .widthIs(80)
        .centerYEqualToView(_headImgView);
    }
    
    return self;
}

- (void)setModel:(StudentModel *)model
{
    _model = model;
    [_headImgView setImageWithImageString:model.studentPhoto];
    //    _sexImgView.hcImageBlock([model. isEqualToString:@"男"]? @"man" : @"woman");
    _nameLb.text = model.name;
    NSString * subject = @"科目";
    for (int i = 1 ; i<5; i++) {
        if ([model.subject containsString:[NSString stringWithFormat:@"%d",i]]) {
            subject= [NSString stringWithFormat:@"%@%@",subject,@[@"一",@"二",@"三",@"四"][i-1]];
        }
    }
    _subjectNameLb.text = subject;
    if (model.isEvaluation == 1) {
        _btn.enabled = YES;
        _btn.backgroundColor = BlueColor;
    }else{
        _btn.enabled = NO;
        _btn.backgroundColor = HexColor(@"999999");
    }
}

- (void)btnTap:(UIButton *)sender
{
    if (self.seeEvaluationBlock) {
        self.seeEvaluationBlock(self.model);
    }
}

@end
