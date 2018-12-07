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

NSString *const CYPinyinGroupResultArray = @"CYPinyinGroupResultArray";
NSString *const CYPinyinGroupCharArray = @"CYPinyinGroupCharArray";

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
    
    _alphabetArray = [[NSMutableArray alloc] init];
    _addressBookArray = [[NSMutableArray alloc] init];
    [self setUI];
    
    [[ApplyPermission sharedInstance] applyPermissionWithPermissionType:ApplyPermissionTypeAddressBook complete:^(BOOL isAllow, BOOL isFirst) {
        NSArray *array =  [AddressBookUtils getAllPeopleInfoToModel];
        NSDictionary *dcit= [self sortObjectsAccordingToInitialWith:array SortKey:@"name"];
        _addressBookArray = dcit[CYPinyinGroupResultArray];//排好顺序的PersonModel数组
        _alphabetArray = dcit[CYPinyinGroupCharArray];//排好顺序的首字母数组
//        NSLog(@"%@-----%@",_addressBookArray,_alphabetArray);
    }];
}

- (void)setUI {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HC_naviHeight, HC_windowWidth, HC_windowHeight-HC_tabBarHeight-HC_naviHeight) style:UITableViewStylePlain];
    [_myTableView registerClass:[AddressBookCell class] forCellReuseIdentifier:@"myCellId"];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
}

#pragma mark - 字母排列
- (NSDictionary *)sortObjectsAccordingToInitialWith:(NSArray *)willSortArr SortKey:(NSString *)sortkey {
    
    // 初始化UILocalizedIndexedCollation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //得出collation索引的数量
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //初始化空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    NSMutableArray *firstChar = [NSMutableArray arrayWithCapacity:10];
    
    //将每个名字分到某个section下
    for (id Model in willSortArr) {
        //获取name属性的值所在的位置
        NSInteger sectionNumber = [collation sectionForObject:Model collationStringSelector:NSSelectorFromString(sortkey)];
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:Model];
        
        //取出每名字的首字母
        NSString *str= collation.sectionTitles[sectionNumber];
        [firstChar addObject:str];
    }
    
    //返回首字母排好序的数据
    NSArray *firstCharResult = [self sortFirstChar:firstChar];
    
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }
    
    //删除空的数组
    NSMutableArray *finalArr = [NSMutableArray new];
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        if (((NSMutableArray *)(newSectionsArray[index])).count != 0) {
            [finalArr addObject:newSectionsArray[index]];
        }
    }
    return @{CYPinyinGroupResultArray:finalArr,CYPinyinGroupCharArray:firstCharResult};
}

- (NSArray *)sortFirstChar:(NSArray *)firstChararry {
    //数组去重复
    NSMutableArray *noRepeat = [[NSMutableArray alloc]initWithCapacity:8];
    NSMutableSet *set = [[NSMutableSet alloc]initWithArray:firstChararry];
    [set enumerateObjectsUsingBlock:^(id obj , BOOL *stop){
        [noRepeat addObject:obj];
    }];
    //字母排序
    NSArray *resultkArrSort1 = [noRepeat sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //把”#“放在最后一位
    NSMutableArray *resultkArrSort2 = [[NSMutableArray alloc]initWithArray:resultkArrSort1];
    if ([resultkArrSort2 containsObject:@"#"]) {
        
        [resultkArrSort2 removeObject:@"#"];
        [resultkArrSort2 addObject:@"#"];
    }
    return resultkArrSort2;
}

#pragma mark - tableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _alphabetArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_addressBookArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellId"];
    if(!cell) {
        cell = [[AddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCellId"];
    }
    NSArray *array =_addressBookArray[indexPath.section];
    HCContact *model = [[HCContact alloc] init];
    model = array[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:@"header"];
    cell.nameLabel.text = model.name;
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array =_addressBookArray[indexPath.section];
    HCContact *model = [[HCContact alloc] init];
    model = array[indexPath.row];
    if(model.phoneNumbers.count > 1) {
        [self showAlertController:model.phoneNumbers];
    } else {
        NSString *phone = model.phoneNumbers[0];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone]]];
    }
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

#pragma mark - alert
- (void)showAlertController:(NSArray *)phoneArray {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:cancelAction];
    for (int i=0; i<phoneArray.count; i++) {
        UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:phoneArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneArray[i]]]];
        }];
        [alertVC addAction:phoneAction];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}









@end
