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


@interface AdressBookVC ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_myTableView;
    NSArray *_alphabetArray;
    NSMutableArray *_addressBookArray;
}
@property(nonatomic, strong) NSMutableArray *addressBookArray;


@end

@implementation AdressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _alphabetArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    _addressBookArray = [[NSMutableArray alloc] init];
    [self setUI];
    HC__weakSelf
    [[ApplyPermission sharedInstance] applyPermissionWithPermissionType:ApplyPermissionTypeAddressBook complete:^(BOOL isAllow, BOOL isFirst) {
        NSArray *array =  [AddressBookUtils getAllPeopleInfoToModel];
        NSLog(@"-------%@", array);
        weakSelf.addressBookArray = [array mutableCopy];
    }];

}

- (void)setUI {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HC_naviHeight, HC_windowWidth, HC_windowHeight-HC_tabBarHeight-HC_naviHeight) style:UITableViewStylePlain];
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
//    _addressBookArray
    
    HCContact *model = _addressBookArray[indexPath.row];
    cell.iconView.image = [[UIImage alloc]initWithData:model.thumbnailImageData];
    cell.nameLabel.text = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HC_windowWidth, 30)];
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
