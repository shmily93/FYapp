//
//  LoginViewController.m
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "MBProgressHUD+Ext.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIImageView *bgImageView;

@property (strong, nonatomic) UIView *middleView, *bottomView;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIImageView *avatarImageView;

@property (strong, nonatomic) UIButton *doneButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - private
- (void)setupSubViews {
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.middleView];
    [self.view addSubview:self.bottomView];
    [self.middleView addSubview:self.nameTextField];
    [self.middleView addSubview:self.passwordTextField];
    [self.bottomView addSubview:self.doneButton];

    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(110);
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(50);
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.offset(0);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(50);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextField.mas_bottom).offset(5);
        make.height.mas_equalTo(50);
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-5);
    }];
    [self.bgImageView startAnimating];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-50);
    }];
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)shouldAutorotate {
    return ([UIApplication sharedApplication].statusBarOrientation
            != UIInterfaceOrientationPortrait);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - action
- (void)loginAction:(id)sender {
    NSLog(@"login");
    self.doneButton.enabled = NO;
//    [MBProgressHUD showLoading:@"加载中" toView:self.view];
    typeof(self) __weak __weak_self__ = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        typeof(__weak_self__) __strong self = __weak_self__;
//    });
    
    [Networking post:@"/mobile/login.do" parameters:@{@"userName":@"fanyi01",@"password":@"fanyi01"} success:^(NSURLSessionDataTask *task, Response *respon) {
        typeof(__weak_self__) __strong self = __weak_self__;
        [MBProgressHUD showSuccLoadingThenHide:@"登陆成功" toView:self.view completionHandler:nil];
        self.doneButton.enabled = YES;
    } failure:^(NSURLSessionDataTask *task, Response *respon) {
        typeof(__weak_self__) __strong self = __weak_self__;
        [MBProgressHUD showErrorLoadingThenHide:respon.message toView:self.view completionHandler:nil];
        self.doneButton.enabled = YES;
    }];
}

#pragma mark - get
- (UIImageView *)bgImageView {
    if(!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.animationImages = @[[UIImage imageNamed:@"login_bg_icon_01"],[UIImage imageNamed:@"login_bg_icon_02"],[UIImage imageNamed:@"login_bg_icon_03"]];
        _bgImageView.animationDuration = 1.5;
    }
    return _bgImageView;
}

- (UITextField *)nameTextField {
    if(!_nameTextField) {
        _nameTextField = [UITextField new];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"login_name_icon"];
        _nameTextField.leftView = leftView;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        _nameTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _nameTextField.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
        _nameTextField.layer.cornerRadius = 5.0f;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _nameTextField;
}

- (UITextField *)passwordTextField {
    if(!_passwordTextField) {
        _passwordTextField = [UITextField new];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"login_pw_icon"];
        _passwordTextField.leftView = leftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _passwordTextField.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
        _passwordTextField.layer.cornerRadius = 5.0f;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwordTextField;
}

- (UIView *)middleView {
    if(!_middleView) {
        _middleView = [UIView new];
        _middleView.backgroundColor = [UIColor clearColor];
    }
    return _middleView;
}

- (UIView *)bottomView {
    if(!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}
- (UIImageView *)avatarImageView {
    if(!_avatarImageView) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.backgroundColor = [UIColor clearColor];
    }
    return _avatarImageView;
}

- (UIButton *)doneButton {
    if(!_doneButton) {
        _doneButton = [UIButton new];
        _doneButton.layer.borderColor = [UIColor grayColor].CGColor;
        _doneButton.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
        _doneButton.layer.cornerRadius = 5.0f;
        [_doneButton setTitle:@"登录" forState:UIControlStateNormal];
        [_doneButton setTitle:@"高亮状态" forState:UIControlStateHighlighted];
        [_doneButton setTitle:@"努力中~" forState:UIControlStateSelected];
        [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}
@end
