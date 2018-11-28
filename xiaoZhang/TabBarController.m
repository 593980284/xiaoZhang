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
    NSArray *itemImageArray = @[@"lx_tabbar_class_normal", @"lx_tabbar_news_normal", @"lx_tabbar_student_normal", @"lx_tabbar_mine_normal"];
    NSArray *itemSelectImageArray = @[@"lx_tabbar_class_select", @"lx_tabbar_news_select", @"lx_tabbar_student_select", @"lx_tabbar_mine_select"];
    NSMutableArray *controllersArray = [NSMutableArray new];
    for (NSInteger i = 0; i < [itemControllerArray count]; i++) {
        UIViewController *vc = [NSClassFromString(itemControllerArray[i]) new];
        BaseNaviVC *naviVC = [[BaseNaviVC alloc]initWithRootViewController:vc];
        naviVC.tabBarItem.title = itemTitleArray[i];
        [controllersArray addObject:naviVC];
    }
    // 加入子控制器
    self.viewControllers = [NSArray arrayWithArray:controllersArray];
    self.selectedIndex = 0;
    [self.tabBar setTintColor:[UIColor colorWithHexString:@"#309CF5"]];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    // 未选中字体
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    // 选中字体
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
}

@end
