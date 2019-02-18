//
//  CoachTableViewCell.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/10.
//  Copyright © 2019年 胡胡超. All rights reserved.
// height 100， top 5  中 93  bottom 2

#import "CourseTableViewCell.h"
@interface CourseTableViewCell()
@property(nonatomic, strong)UIImageView *headImgView;
@property(nonatomic, strong)UIImageView *sexImgView;
@property(nonatomic, strong)UIImageView *idImgView_1;
@property(nonatomic, strong)UIImageView *idImgView_2;
@property(nonatomic, strong)UILabel *nameLb;
@property(nonatomic, strong)UILabel *subjectNameLb;
@property(nonatomic, strong)UILabel *timeLb;
@property(nonatomic, strong)UILabel *numLb;
@end
@implementation CourseTableViewCell

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
        _idImgView_1 = [UIImageView new];
        _idImgView_2 = [UIImageView new];
        
        _nameLb = [UILabel new];
        _nameLb.hcTextBlock(TitleColor_333, Font(16, 14), 0);
        
        _subjectNameLb = [UILabel new];
        _subjectNameLb.hcTextBlock(DetialColor_666, SystemFont(12), 0);
       
        UIView *line1 = [UIView new];
        line1.backgroundColor = HexColor(@"#E3E3E3");
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = HexColor(@"#E3E3E3");
        
        _timeLb = [UILabel new];
        _timeLb.hcTextBlock(DetialColor_666, SystemFont(12), 0);
        
        _numLb = [UILabel new];
        _numLb.lineBreakMode = NSLineBreakByTruncatingHead;
        _numLb.hcTextBlock(DetialColor_666, SystemFont(12), 0);
        [bgView sd_addSubviews:@[_headImgView, _sexImgView, _nameLb, _idImgView_1, _idImgView_2, _subjectNameLb, line1, _timeLb, line2, _numLb]];
        CGFloat pad = 10;
        if(HC_windowWidth <= 320){
            pad = 4;
            _numLb.adjustsFontSizeToFitWidth = YES;
        }
        NSLog(@"%lf",HC_windowWidth );
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
        
        _idImgView_1.sd_layout
        .heightIs(35/2.0)
        .widthIs(60)
        .topSpaceToView(_nameLb, 3)
        .leftEqualToView(_nameLb);
        
        _idImgView_2.sd_layout
        .heightIs(35/2.0)
        .widthIs(60)
        .topSpaceToView(_nameLb, 3)
        .leftSpaceToView(_idImgView_1, 5);
        
        _subjectNameLb.sd_layout
        .heightIs(15)
        .leftEqualToView(_nameLb)
        .bottomEqualToView(_headImgView);
        [_subjectNameLb setSingleLineAutoResizeWithMaxWidth:300];
        
        line1.sd_layout
        .centerYEqualToView(_subjectNameLb)
        .leftSpaceToView(_subjectNameLb, pad)
        .heightIs(8)
        .widthIs(1);
        
        _timeLb.sd_layout
        .heightIs(15)
        .leftSpaceToView(line1, pad)
        .bottomEqualToView(_headImgView);
        [_timeLb setSingleLineAutoResizeWithMaxWidth:300];
        
        line2.sd_layout
        .centerYEqualToView(_timeLb)
        .leftSpaceToView(_timeLb, pad)
        .heightIs(8)
        .widthIs(1);
        
        _numLb.sd_layout
        .heightIs(15)
        .leftSpaceToView(line2, pad)
        .bottomEqualToView(_headImgView)
        .rightSpaceToView(bgView, 0);
      
    }
    return self;
}

- (void)setModel:(CourseModel *)model
{
    _model = model;
    
    [_headImgView setImageWithImageString:model.coachPhoto];
    _sexImgView.hcImageBlock([model.coachSex isEqualToString:@"男"]? @"man" : @"woman");
    _nameLb.text = model.coachName;
    _subjectNameLb.text = model.subjectName;
    _timeLb.text = model.shortPeriodTime;
    _numLb.text = [NSString stringWithFormat:@"已约课（%@/%@）", model.appointmentNum, model.maxNum];
//    131000：金牌教练
//    132000：十佳优秀党员
     _idImgView_1.hidden = NO;
    _idImgView_2.hidden = NO;
    if ([model.identity containsString:@"131000"]) {
        _idImgView_1.hcImageBlock(@"金牌教练");
        if ([model.identity containsString:@"132000"]) {
            _idImgView_2.hcImageBlock(@"十佳党员");
        }else{
            _idImgView_2.hidden = YES;
        }
    }else{
        _idImgView_2.hidden = YES;
        if ([model.identity containsString:@"132000"]) {
            _idImgView_1.hcImageBlock(@"十佳党员");
        }else{
            _idImgView_1.hidden = YES;
        }
    }
    
}
@end
