//
//  LoginViewController.m
//  FYapp
//
//  Created by fanyi on 2017/9/12.
//  Copyright © 2017年 fanyi. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIImageView *bgImageView;

@property (strong, nonatomic) UIView *middleView;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIImageView *avatarImageView;

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

#pragma mark - private
- (void)setupSubViews {
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.middleView];
    [self.middleView addSubview:self.nameTextField];
    [self.middleView addSubview:self.passwordTextField];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(110);
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-50);
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
}

#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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

- (UIImageView *)avatarImageView {
    if(!_avatarImageView) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.backgroundColor = [UIColor clearColor];
    }
    return _avatarImageView;
}

@end
