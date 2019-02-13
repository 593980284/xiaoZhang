//
//  TabBarController.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "TabBarController.h"
#import "BaseNaviVC.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController];
}

- (void)addChildViewController {
    NSArray *itemControllerArray = @[@"HomeVC", @"CourseVC", @"AdressBookVC", @"mineVC"];
    NSArray *itemTitleArray = @[@"首页", @"课程", @"通讯录", @"我的"];
    NSArray *itemImageArray = @[@"tab_1_u", @"tab_2_u", @"tab_3_u", @"tab_4_u"];
    NSArray *itemSelectImageArray = @[@"tab_1_s", @"tab_2_s", @"tab_3_s", @"tab_4_s"];
    NSMutableArray *controllersArray = [NSMutableArray new];
    for (NSInteger i = 0; i < [itemControllerArray count]; i++) {
        UIViewController *vc = [NSClassFromString(itemControllerArray[i]) new];
        BaseNaviVC *naviVC = [[BaseNaviVC alloc]initWithRootViewController:vc];
        naviVC.tabBarItem.title = itemTitleArray[i];
        naviVC.tabBarItem.selectedImage = [UIImage imageNamed: itemSelectImageArray[i]];
        naviVC.tabBarItem.image  = [UIImage imageNamed: itemImageArray[i]];
        [controllersArray addObject:naviVC];
    }
    // 加入子控制器
    self.viewControllers = [NSArray arrayWithArray:controllersArray];
    self.selectedIndex = 0;
    [self.tabBar setTintColor:BlueColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    // 未选中字体
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    // 选中字体
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
}

@end
