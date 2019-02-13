//
//  CourseDateView.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/2/9.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "CourseDateView.h"
@interface CourseDateItem: UIView
@property(nonatomic, assign)BOOL isSelected;
@property(nonatomic, copy)NSString *dateStr;

@property(nonatomic, strong)UILabel *weekdayLb;
@property(nonatomic, strong)UILabel *dateLb;
- (instancetype)initWithDate:(NSString *)dateStr;
@end
@implementation CourseDateItem
- (instancetype)initWithDate:(NSString *)dateStr
{
    if (self = [super init]) {
        _weekdayLb = [UILabel new];
        _weekdayLb.hcTextBlock(PlaceholderColor_333, [UIFont systemFontOfSize:12], 1);
        
        _dateLb = [UILabel new];
        _dateLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:12], 1)
        .hcCornerRadiusBlock(12.5, YES);
        
        [self sd_addSubviews:@[_weekdayLb, _dateLb]];
        
        _weekdayLb.sd_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(25);
        
        _dateLb.sd_layout
        .bottomSpaceToView(self, 0)
        .centerXEqualToView(self)
        .heightIs(25)
        .widthIs(25);
        
        self.dateStr = dateStr;
    }
    return self;
}

-(void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [format dateFromString:dateStr];
    self.weekdayLb.text = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"][date.weekday-1];
    self.dateLb.text = [dateStr componentsSeparatedByString:@"-"].lastObject;
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.dateLb.backgroundColor = HexColor(@"#BAD9FF");
    }else{
        self.dateLb.backgroundColor = [UIColor clearColor];
    }
    
}
@end
@interface CourseDateView()
@property(nonatomic, strong)UILabel *dateLb;
@property(nonatomic, strong)NSMutableArray *lbs;
@property(nonatomic, strong)UIScrollView *scrollView;
@end
@implementation CourseDateView

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
        self.lbs = [NSMutableArray new];
        self.dateLb = [UILabel new];
        self.dateLb.hcTextBlock(TitleColor_333, [UIFont systemFontOfSize:14 weight:14], 0);
        
        [self addSubview:self.dateLb];
        
        self.dateLb.sd_layout
        .heightIs(10)
        .leftSpaceToView(self, 20)
        .topSpaceToView(self, 15)
        .widthIs(200);
        
        self.scrollView = [UIScrollView new];
        
        [self addSubview:self.scrollView];
        self.scrollView.sd_layout
        .topSpaceToView(self.dateLb, 15)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
        
    }
    return self;
}

- (void)setDateArr:(NSArray *)dateArr
{
    _dateArr = dateArr;
    [self.lbs removeAllObjects];
    [self.scrollView removeAllSubviews];
    CGFloat itemWidth = 55;
    self.scrollView.contentSize = CGSizeMake(dateArr.count * itemWidth, 0);
    for (int i = 0 ; i < dateArr.count; i ++) {
        CourseDateItem *item = [[CourseDateItem alloc]initWithDate:dateArr[i]];
        item.tag = 100 + i;
        item.hcTapBlock(self, @selector(tap:));
        item.isSelected = i == 0;
        [self.scrollView addSubview:item];
        item.sd_layout
        .topSpaceToView(self.scrollView, 0)
        .widthIs(itemWidth)
        .heightIs(60)
        .leftSpaceToView(self.scrollView, itemWidth*i);
        
        if (i == 0) {
            NSArray *arr = [dateArr[0] componentsSeparatedByString:@"-"];
            if (arr.count == 3) {
                self.dateLb.text = [NSString stringWithFormat:@"%@-%@",arr[0], arr[1]];
            }
        }
        
        [self.lbs addObject:item];
    }
}

- (void)tap:(UITapGestureRecognizer *)gr
{
    CourseDateItem *item = (CourseDateItem *) gr.view;
    if (item.isSelected) {
        return;
    }
    for (CourseDateItem * view in self.lbs) {
        view.isSelected = NO;
    }
    item.isSelected = YES;
    
    NSArray *arr = [item.dateStr  componentsSeparatedByString:@"-"];
    if (arr.count == 3) {
        self.dateLb.text = [NSString stringWithFormat:@"%@-%@",arr[0], arr[1]];
    }    
    if (self.tapBlock) {
        self.tapBlock(item.dateStr);
    }
}

@end
