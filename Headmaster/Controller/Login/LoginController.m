//
//  LoginController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "LoginController.h"

#define h_center self.view.center
#define h_size [UIScreen mainScreen].bounds.size
#define h_iconViewHeight [UIScreen mainScreen].bounds.size.height *56/667
#define h_iconViewWidth [UIScreen mainScreen].bounds.size.width *61/375
#define h_iconViewTOP [UIScreen mainScreen].bounds.size.height *150/667 +1
#define h_phoneTFHeight [UIScreen mainScreen].bounds.size.height *60/667
#define h_loginBtnHeight [UIScreen mainScreen].bounds.size.height *50/667
#define h_numLabelHeight [UIScreen mainScreen].bounds.size.height *40/667

@interface LoginController () <UITextFieldDelegate> {
    UITextField *_phoneTF;
    UITextField *_passwordTF;
    UIImageView *_iv;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self addNotify];
}

- (void)createUI {
    _iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _iv.image = [UIImage imageNamed:@"bg_login"];
    [self.view addSubview:_iv];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(h_center.x -h_iconViewWidth/2, h_iconViewTOP, h_iconViewWidth, h_iconViewHeight)];
    iconView.image = [UIImage imageNamed:@"icon120x110.png"];
    [self.view addSubview:iconView];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(26, iconView.frame.origin.y +iconView.frame.size.height +h_iconViewTOP , h_size.width -26, h_phoneTFHeight)];
    _phoneTF.placeholder = @"账号";
    _phoneTF.textColor = [self colorWithHexString:@"#fefefe"];
    _phoneTF.text = @"15652305651";
    [_phoneTF setValue:[self colorWithHexString:@"#bfbfbf"] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _phoneTF.delegate = self;
    
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTF];
    
    UIImageView *phoneView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13, 20 , 19)];
    phoneView.image = [UIImage imageNamed:@"yh38x36.png"];
    
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 46, 50)];
    upView.backgroundColor = [UIColor clearColor];
    [upView addSubview:phoneView];
    
    _phoneTF.leftView = upView;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *lineViewUP = [[UIView alloc] initWithFrame:CGRectMake(0, _phoneTF.frame.origin.y +h_phoneTFHeight , h_size.width, 1)];
    lineViewUP.backgroundColor = [UIColor whiteColor];
    lineViewUP.alpha = 0.1;
    [self.view addSubview:lineViewUP];
    
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(26, _phoneTF.frame.origin.y +_phoneTF.frame.size.height+1 , h_size.width -26, h_phoneTFHeight)];
    _passwordTF.placeholder = @"密码";
    _passwordTF.textColor = [self colorWithHexString:@"#fefefe"];
    _passwordTF.text = @"123456";
    [_passwordTF setValue:[self colorWithHexString:@"#bfbfbf"] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _passwordTF.delegate = self;
    _passwordTF.secureTextEntry = YES;
    [self.view addSubview:_passwordTF];
    
    UIImageView *passwordView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13, 20 , 21)];
    passwordView.image = [UIImage imageNamed:@"mm38x36.png"];
    
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 46, 50)];
    downView.backgroundColor = [UIColor clearColor];
    [downView addSubview:passwordView];
    
    _passwordTF.leftView = downView;
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *lineViewDown = [[UIView alloc] initWithFrame:CGRectMake(0, _passwordTF.frame.origin.y +h_phoneTFHeight , h_size.width, 1)];
    lineViewDown.backgroundColor = [UIColor whiteColor];
    lineViewDown.alpha = 0.1;
    [self.view addSubview:lineViewDown];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _passwordTF.frame.origin.y +_passwordTF.frame.size.height +h_loginBtnHeight, h_size.width , h_loginBtnHeight)];
    loginButton.backgroundColor = [self colorWithHexString:@"#01E4B7"];
    [loginButton setTitle:@"登入" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:21];
    [loginButton setTitleColor:[self colorWithHexString:@"#fefefe"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(buttonIsClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UILabel *numberLb = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, h_numLabelHeight)];
    numberLb.text = @"联系客服";
    numberLb.font = [UIFont italicSystemFontOfSize:12];
    numberLb.textColor = [self colorWithHexString:@"#fefefe"];
    [numberLb sizeToFit];
    numberLb.center = CGPointMake(h_center.x,  h_size.height -h_numLabelHeight);
    [self.view addSubview:numberLb];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_passwordTF.text isEqualToString:@""]) {
        _passwordTF.placeholder = @"密码";
    }
    if ([_phoneTF.text isEqualToString:@""]) {
        _phoneTF.placeholder = @"账号";
    }
}

- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

- (void)addNotify {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keybardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keybardWillShow:(NSNotification *)notify
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.bounds = CGRectMake(0, h_iconViewTOP +h_iconViewHeight *3 , self.view.bounds.size.width, self.view.bounds.size.height);
    }];
    CGRect frame = self.view.bounds;
    frame.origin.y = h_iconViewTOP +h_iconViewHeight *3 ;
    _iv.frame = frame;
}

-(void)keyboardWillHidden
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect bounds = self.view.bounds;
        bounds.origin = CGPointZero;
        self.view.bounds = bounds;
    }];
    CGRect frame = self.view.bounds;
    _iv.frame = frame;
}

- (void)buttonIsClick {
    [self.view endEditing:YES];
    NSLog(@"%@",_phoneTF.text);
    NSLog(@"%@",_passwordTF.text);
    [NetworkEntity loginWithPhotoNumber:_phoneTF.text password:_passwordTF.text success:^(id responseObject) {
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            UserInfoModel *uim = [UserInfoModel defaultUserInfo];
            BOOL isLogin = [uim loginViewDic:responseObject];
            NSLog(@"%@",[responseObject objectForKey:@"msg"]);
            if (isLogin) {
                NSLog(@"==================%@",uim.name);
            }
        }else {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:[responseObject objectForKey:@"msg"]];
            [toastView show];
        }
    } failure:^(NSError *failure) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络连接失败"];
        [toastView show];
    }];
    

//    UserInfoModel *uim = [UserInfoModel defaultUserInfo];
//    [uim loginOut];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -----UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 0) {
        if (range.location>10) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
