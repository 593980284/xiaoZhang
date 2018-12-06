//
//  AdressBookVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "AdressBookVC.h"
#import "AddressBookUtils.h"
#import "ApplyPermission.h"
#import "AddressBookCell.h"

#define FULL_WIDTH  [UIScreen mainScreen].bounds.size.width
#define FULL_HEIGHT [UIScreen mainScreen].bounds.size.height

#define isIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

//屏幕比例 屏宽／375
#define SCREEN_SCALE (FUll_VIEW_WIDTH/375)

//iPHONE_X 判断
#define IS_iPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_iPHONE_X ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (IS_iPHONE_X ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (IS_iPHONE_X ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (IS_iPHONE_X ? 34.f : 0.f)


@interface AdressBookVC ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_myTableView;
    NSArray *_alphabetArray;
    NSMutableArray *_addressBookArray;
}

@end

@implementation AdressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _alphabetArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    _addressBookArray = [[NSMutableArray alloc] init];
    [self setUI];
    
    [[ApplyPermission sharedInstance] applyPermissionWithPermissionType:ApplyPermissionTypeAddressBook complete:^(BOOL isAllow, BOOL isFirst) {
        NSArray * a =  [AddressBookUtils getAllPeopleInfoToModel];
        NSLog(@"%@", a);
    }];
}

- (void)setUI {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, FULL_WIDTH, FULL_HEIGHT-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [_myTableView registerClass:[AddressBookCell class] forCellReuseIdentifier:@"myCellId"];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _alphabetArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellId"];
    if(!cell) {
        cell = [[AddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCellId"];
    }
    cell.iconView.image = [UIImage imageNamed:@"header"];
    cell.nameLabel.text = @"大大大大王叫我来巡山";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = [NSString stringWithFormat:@"%@",_alphabetArray[section]];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _alphabetArray;
}









@end
