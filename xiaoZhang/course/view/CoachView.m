//
//  CoachView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/11.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CoachView.h"
#import "LEEStarRating.h"
@interface CoachView()
@property(nonatomic, strong)UIImageView *headImgView;
@property(nonatomic, strong)UIImageView *sexImgView;
@property(nonatomic, strong)UIImageView *idImgView_1;
@property(nonatomic, strong)UIImageView *idImgView_2;
@property(nonatomic, strong)UILabel *nameLb;
@property(nonatomic, strong)UILabel *subjectNameLb;
@property(nonatomic, strong)LEEStarRating *starView;
@end
@implementation CoachView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _headImgView = [UIImageView new];
        _sexImgView = [UIImageView new];
        _idImgView_1 = [UIImageView new];
        _idImgView_2 = [UIImageView new];
        
        _nameLb = [UILabel new];
        _nameLb.hcTextBlock(TitleColor_333, Font(16, 14), 0);
        
        _subjectNameLb = [UILabel new];
        _subjectNameLb.hcTextBlock(DetialColor_666, SystemFont(12), 0);
        
        _starView = [[LEEStarRating alloc]initWithFrame:CGRectMake(0, 0, 90, 15) Count:5];
        _starView.type = RatingTypeHalf;
        _starView.spacing = 3;
        
        
         [self sd_addSubviews:@[_headImgView,
                                  _sexImgView,
                                  _nameLb,
                                  _idImgView_1,
                                  _idImgView_2,
                                  _subjectNameLb,
                                  _starView]];
        
        _headImgView.sd_layout
        .topSpaceToView(self, 8)
        .leftSpaceToView(self, 10)
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
        .rightSpaceToView(self, 0)
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
        
        _starView.sd_layout
        .rightSpaceToView(self, 12)
        .centerYEqualToView(_nameLb)
        .heightIs(15)
        .widthIs(90);
    }
    return self;
}

- (void)setCourseDetailModel:(CourseDetailModel *)courseDetailModel
{
    _courseDetailModel = courseDetailModel;
    [_headImgView setImageWithImageString:courseDetailModel.coachPhoto];
    _sexImgView.hcImageBlock([courseDetailModel.coachSex isEqualToString:@"男"]? @"man" : @"woman");
    _nameLb.text = courseDetailModel.coachName;
    _subjectNameLb.text = [NSString stringWithFormat:@"%@教龄·%@", courseDetailModel.teachAge, courseDetailModel.teachType];
    //    131000：金牌教练
    //    132000：十佳优秀党员
    _idImgView_1.hidden = NO;
    _idImgView_2.hidden = NO;
    if ([courseDetailModel.identity containsString:@"131000"]) {
        _idImgView_1.hcImageBlock(@"金牌教练");
        if ([courseDetailModel.identity containsString:@"132000"]) {
            _idImgView_2.hcImageBlock(@"十佳党员");
        }else{
            _idImgView_2.hidden = YES;
        }
    }else{
        _idImgView_2.hidden = YES;
        if ([courseDetailModel.identity containsString:@"132000"]) {
            _idImgView_1.hcImageBlock(@"十佳党员");
        }else{
            _idImgView_1.hidden = YES;
        }
    }
    
    _starView.currentScore = courseDetailModel.coachStar / 2.0;
}

@end
