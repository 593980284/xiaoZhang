//
//  SetVC.m
//  xiaoZhang
//
//  Created by 胡胡超 on 2019/1/25.
//  Copyright © 2019年 胡胡超. All rights reserved.
//

#import "SetVC.h"
#import "CBImagePicker.h"
#import "SetCell.h"
#import "LoginVC.h"
#import "ModifyPhoneVC.h"
@interface SetVC ()
@property(nonatomic, strong)UIImageView *headerImgView;
@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人设置";
    [self setUI];
}

- (void)reloadData
{
    UserModel * model = [[UserStorage shareInstance] getUserModel];
    [self.headerImgView setImageWithImageString:model.photo placeholderString:@"head"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)setUI
{
    self.headerImgView = [UIImageView new];
    UIButton *editBtn = [UIButton new];
    editBtn.hcNomalTextBlock(BlueColor, @"编辑头像", [UIFont systemFontOfSize:12])
    .hcTapBlock(self, @selector(editBtnTap:));
    [editBtn setImage:[UIImage imageNamed:@""] forState:0];
    
    [self.view addSubview:self.headerImgView];
    [self.view addSubview:editBtn];
    
    self.headerImgView.sd_layout
    .topSpaceToView(self.view, HC_naviHeight + 40)
    .heightIs(100)
    .widthIs(100)
    .centerXEqualToView(self.view);
    
    editBtn.sd_layout
    .topSpaceToView(self.headerImgView, 5)
    .centerXEqualToView(self.view)
    .heightIs(40)
    .widthIs(100);
    NSArray *data = @[ @"更换登录手机号"];
    for (int i = 0; i < data.count; i++) {
        SetCell *cell = [[SetCell alloc]initWithTitle:data[i]];
        cell.hcTapBlock(self, @selector(cellTap:));
        cell.tag = 100 + i;
        [self.view addSubview:cell];
        cell.sd_layout
        .topSpaceToView(editBtn, 20 + 55*i)
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .heightIs(55);
    }
    
    UIButton *signOutBtn = [UIButton new];
    signOutBtn.hcNomalTextBlock([UIColor whiteColor], @"退出登录", [UIFont systemFontOfSize:18])
    .hcBgColorBlock(BlueColor)
    .hcCornerRadiusBlock(4, YES)
    .hcTapBlock(self, @selector(signOut:));
    
    [self.view addSubview:signOutBtn];
    signOutBtn.sd_layout
    .topSpaceToView(editBtn, 20 + 55 * data.count + 86)
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .heightIs(45);

}

- (void)cellTap:(UITapGestureRecognizer *)gr
{
    switch (gr.view.tag - 100) {
        case 0:
            {
                ModifyPhoneVC *vc =  [ModifyPhoneVC new];
                vc.step = ModifyPhoneStepOne;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 1:
        {
           ModifyPhoneVC *vc =  [ModifyPhoneVC new];
            vc.step = ModifyPhoneStepOne;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)signOut:(UIButton *)sender
{
    HC__weakSelf
    [NetWorkTool requestWithURL:MineApi_signOut params:@{} toModel:nil success:^(id result) {
        [[UserStorage shareInstance]removeUserData];
        [weakSelf presentViewController:[LoginVC new] animated:YES completion:nil];
    } failure:^(NSString *msg, NSInteger code) {
        if (code == -2) {
            [[UserStorage shareInstance]removeUserData];
            [weakSelf presentViewController:[LoginVC new] animated:YES completion:nil];
        }else{
           [MBProgressHUD showError:msg];
        }
    } showLoading:@""];
}

- (void)editBtnTap:(UIButton *)sender
{
    
    [self startPicker];
}


- (void)uploadImage:(UIImage *)image
{
    HC__weakSelf
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    NSString * base64 = [data base64EncodedString];
    NSString * phone  = [[UserStorage shareInstance] getUserModel].phone;
    if (phone.isEmpty) {
        [MBProgressHUD showSuccess:@"请重新登录"];
        return;
    }
    if (base64.isEmpty) {
        [MBProgressHUD showSuccess:@"请重新选择头像"];
        return;
    }
    [NetWorkTool requestWithURL:MineApi_uploadHead
                         params:@{@"phone": phone,@"imageCode": base64 }
                        toModel:nil
                        success:^(NSDictionary * result) {
                            if (result && result[@"picUrl"]) {
                                [[UserStorage shareInstance] saveUserDataWithValue:result[@"picUrl"] forKey:@"photo"];
                                [weakSelf reloadData];
                            }
                             [MBProgressHUD showSuccess:@"上传成功" toView:weakSelf.view];
    } failure:^(NSString *msg, NSInteger code) {
        [MBProgressHUD showSuccess:@"上传失败" toView:weakSelf.view];

    } showLoading:@""];
}

-(void)startPicker{
    HC__weakSelf
    CBImagePicker * picker = [CBImagePicker shared];
    [picker startWithVC:self];
    [picker setPickerCompletion:^(CBImagePicker * picker, NSError *error, UIImage *image) {
        if (!error) {
            [weakSelf  uploadImage: image];
        }else{
            NSLog(@"error.description = %@",error.userInfo[@"description"]);
        }
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
