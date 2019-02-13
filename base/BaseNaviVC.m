//
//  BaseNaviVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2018/11/28.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "BaseNaviVC.h"
#import "GKWrapViewController.h"
@interface BaseNaviVC ()

@end

@implementation BaseNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        if ([viewController isKindOfClass:[GKWrapViewController class]]) {
            GKWrapViewController *vc = (GKWrapViewController *)viewController;
            vc.contentViewController.hidesBottomBarWhenPushed = YES;
            
            UIButton *btn = [UIButton new];
            btn.frame = CGRectMake(0, 0, 44, 44);
            [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:@"back"] forState:0];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, - 10, 0, 10);
             UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            vc.contentViewController.navigationItem.leftBarButtonItem = backItem;
            
        }else{
          viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
        }
        
    }
    
    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view并调用viewController的viewDidLoad方法。可以在viewDidLoad方法中重新设置自己想要的左上角按钮样式
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
