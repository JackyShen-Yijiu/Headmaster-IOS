//
//  LoginController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "LoginController.h"
#import "NSString+MD5.h"
#import "DVVTabBarController.h"
#import "MenuController.h"
#import "UserCenterController.h"
#import "APService.h"
#import "EaseSDKHelper.h"


#define h_center self.view.center
#define h_size [UIScreen mainScreen].bounds.size
#define h_iconViewHeight [UIScreen mainScreen].bounds.size.height *91/667
#define h_iconViewWidth [UIScreen mainScreen].bounds.size.width *109/375
#define h_iconViewTOP [UIScreen mainScreen].bounds.size.height *104/667
#define h_phoneTFHeight [UIScreen mainScreen].bounds.size.height *60/667
#define h_loginBtnHeight [UIScreen mainScreen].bounds.size.height *50/667
#define h_numLabelHeight [UIScreen mainScreen].bounds.size.height *20/667



#define h_bgH  [UIScreen mainScreen].bounds.size.height *103/667

@interface LoginController () <UITextFieldDelegate> {
    
    UITextField *_phoneTF;
    UITextField *_passwordTF;
    UIImageView *_BackgroundImage;
    UIImageView *_phoneLeftView;
    UIImageView *_iconView;
    UIImageView *_phoneView;
    UIView *_upView;
    UIView *_lineViewUP;
    UIImageView *_passwordView;
    UIView *_downView;
    UIView *_lineViewDown;
    UIButton *_loginButton;
    UIButton *_callBtn;
    UIView *_phoneAndPasswordBG;
    UIView *_bottomLineView;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self configeUI];
    [self updateUI];
    [self addNotify];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)initUI {
    
    
    
    [self createUI];
    [self addNotify];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    [self.myNavController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)createUI {
    _BackgroundImage = [[UIImageView alloc] init];    //背景图片
    [self.view addSubview:_BackgroundImage];
    
    _iconView = [[UIImageView alloc] init];          //logo
    [self.view addSubview:_iconView];
    
    _phoneAndPasswordBG = [[UIView alloc] init];
    _phoneAndPasswordBG.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    _phoneAndPasswordBG.alpha = 0.1;
    [self.view addSubview:_phoneAndPasswordBG];
    
    _phoneTF = [[UITextField alloc] init];           //账号输入框
    _phoneTF.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_phoneTF];
    
    _upView = [[UIView alloc] init];                 //账号输入框左侧的父视图
    _phoneTF.leftView = _upView;
    
    _phoneView = [[UIImageView alloc]init];          //账号输入框的icon
    [_upView addSubview:_phoneView];
    
    _lineViewUP = [[UIView alloc] init];             //账号输入框下的线
    _lineViewUP.backgroundColor = [UIColor colorWithHexString:@"585968"];
    [self.view addSubview:_lineViewUP];
    
    _passwordTF = [[UITextField alloc] init];        //密码输入框
    [self.view addSubview:_passwordTF];
    
    _downView = [[UIView alloc] init];               //密码输入框左侧的父视图
    _passwordTF.leftView = _downView;
    
    _passwordView = [[UIImageView alloc]init];       //密码输入框的icon
    [_downView addSubview:_passwordView];
    
//    _lineViewDown = [[UIView alloc] init];           //密码输入框下的线
//    [self.view addSubview:_lineViewDown];
    
    _loginButton = [[UIButton alloc] init];          //登录按钮
    [self.view addSubview:_loginButton];
    
    _callBtn = [[UIButton alloc] init];              //联系我们
    [self.view addSubview:_callBtn];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = [UIColor colorWithHexString:@"#9A9DA6"];
    [self.view addSubview:_bottomLineView];
    
    
}

- (void)updateUI {
    
    
    _BackgroundImage.frame = self.view.bounds;
    
    _iconView.frame         = CGRectMake(h_center.x -h_iconViewWidth/2, h_iconViewTOP, h_iconViewWidth, h_iconViewHeight);
    
    _phoneAndPasswordBG.frame = CGRectMake(15,CGRectGetMaxY(_iconView.frame) + [UIScreen mainScreen].bounds.size.height *116/667,  h_size.width -30, h_bgH);

    _phoneTF.frame          = CGRectMake(15,CGRectGetMaxY(_iconView.frame) + [UIScreen mainScreen].bounds.size.height *116/667, _phoneAndPasswordBG.width, (_phoneAndPasswordBG.height - 1) / 2);
    
    _phoneView.frame        = CGRectMake(0, -1, 32 , 32);
    _upView.frame           = CGRectMake(0, 0, 32,32);
    
    
    _lineViewUP.frame       = CGRectMake(17,CGRectGetMaxY(_phoneTF.frame) , _phoneAndPasswordBG.width - 4, 1);
    
    _passwordTF.frame       = CGRectMake(15, CGRectGetMaxY(_phoneTF.frame) + 1 , _phoneAndPasswordBG.width, (_phoneAndPasswordBG.height - 1) / 2);
    _passwordView.frame     = CGRectMake(0, -1,32 , 32);
    _downView.frame         = CGRectMake(0, 0, 32, 32);
    
    
    _lineViewDown.frame     = CGRectMake(0, _passwordTF.frame.origin.y +h_phoneTFHeight , h_size.width, 1);
    _loginButton.frame      = CGRectMake(15, CGRectGetMaxY(_phoneAndPasswordBG.frame) + [UIScreen mainScreen].bounds.size.height *40/667, h_size.width - 30 , h_loginBtnHeight);
    
    _callBtn.frame          = CGRectMake(0,0, 144, h_numLabelHeight);
    _callBtn.center         = CGPointMake(h_center.x,  h_size.height -h_numLabelHeight);
    
    _bottomLineView.frame = CGRectMake(0, 0, 55, 1);
    _bottomLineView.center = CGPointMake(h_center.x + 32, h_size.height -10);
    if (YBIphone6Plus) {
        _bottomLineView.center = CGPointMake(h_center.x + 32, h_size.height -14);
    }
    
    
   }

- (void)configeUI {
    _BackgroundImage.image = [UIImage imageNamed:@"JZ_bg"];
    
    _iconView.contentMode = UIViewContentModeCenter;
    _iconView.image = [UIImage imageNamed:@"JZ_image_logo"];
    
    _phoneTF.placeholder = @"请输入用户名";
    _phoneTF.textColor = [UIColor colorWithHexString:@"#E4E5E6"];
    [_phoneTF setValue:[UIColor colorWithHexString:@"#C8CACD"] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _phoneTF.delegate = self;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    _phoneView.image = [UIImage imageNamed:@"JZ_icon_name"];
    
    _upView.backgroundColor = [UIColor clearColor];
    
    _lineViewUP.backgroundColor = [UIColor whiteColor];
    _lineViewUP.alpha = 0.1;
    
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.textColor = [UIColor colorWithHexString:@"#E4E5E6"];
    [_passwordTF setValue:[UIColor colorWithHexString:@"#C8CACD"] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _passwordTF.delegate = self;
    _passwordTF.secureTextEntry = YES;
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    _passwordView.image = [UIImage imageNamed:@"JZ_icon_password"];
    
    _downView.backgroundColor = [UIColor clearColor];
    
    _lineViewDown.backgroundColor = [UIColor whiteColor];
    _lineViewDown.alpha = 0.1;
    
    _loginButton.backgroundColor = [UIColor colorWithHexString:@"26CCC0"];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_loginButton setTitleColor:[UIColor colorWithHexString:@"#fefefe"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(buttonIsClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_callBtn setTitle:@"没有账号?联系我们" forState:UIControlStateNormal];
    _callBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_callBtn setTitleColor:[UIColor colorWithHexString:@"#9A9DA6"] forState:UIControlStateNormal];
    [_callBtn addTarget:self action:@selector(callNum) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_passwordTF.text isEqualToString:@""]) {
        _passwordTF.placeholder = @"请输入用户名";
    }
    if ([_phoneTF.text isEqualToString:@""]) {
        _phoneTF.placeholder = @"请输入密码";
    }
}

#pragma mark - notify


- (void)addNotify {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keybardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keybardWillShow:(NSNotification *)notify
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.bounds = CGRectMake(0, h_iconViewTOP +h_iconViewHeight , self.view.bounds.size.width, self.view.bounds.size.height);
    }];
    CGRect frame = self.view.bounds;
    frame.origin.y = h_iconViewTOP +h_iconViewHeight ;
    _BackgroundImage.frame = frame;
}

-(void)keyboardWillHidden
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect bounds = self.view.bounds;
        bounds.origin = CGPointZero;
        self.view.bounds = bounds;
    }];
    CGRect frame = self.view.bounds;
    _BackgroundImage.frame = frame;
}

#pragma mark - buttonClick


- (void)buttonIsClick {
    
    [self.view endEditing:YES];
    
    [NetworkEntity loginWithPhotoNumber:_phoneTF.text password:_passwordTF.text success:^(id responseObject) {
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            
            NSMutableDictionary * loginInfo = [responseObject mutableCopy];
            [NetworkTool setHTTPHeaderField:[[loginInfo objectForKey:@"data"] objectForKey:@"token"]];
            [loginInfo setValue:[_passwordTF.text MD5Digest]forKey:@"md5Pass"];
            
            [[UserInfoModel defaultUserInfo] loginViewDic:loginInfo];
            
            [[MenuController defaultImageView] sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait]];
            
            //极光推送设置alias
            [APService setAlias:[UserInfoModel defaultUserInfo].userID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
            
            //友盟账号统计
            [MobClick profileSignInWithPUID:_phoneTF.text];
            
            [[EaseMob sharedInstance].chatManager removeAllConversationsWithDeleteMessages:YES append2Chat:NO];

            if ([_delegate respondsToSelector:@selector(loginControllerDidLoginSucess:)]) {
                [_delegate loginControllerDidLoginSucess:self];
            }
        }else {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:[responseObject objectForKey:@"msg"]];
            [toastView show];
        }
    } failure:^(NSError *failure) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络连接失败"];
        [toastView show];
    }];

}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)callNum {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-53658566"]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (UIViewController *)rootViewController {
    
    NSArray *controllerArray = @[ @"HomeController",
                                  @"InformationController",
                                  @"RecommendViewController" ];
    
    NSArray *titleArray = @[ @"数据概览", @"资讯", @"消息" ];
    
    DVVTabBarController *tabBarVC = [DVVTabBarController new];
    
    // 循环创建Controller
    for (NSInteger i = 0; i < controllerArray.count; i++) {
        
        Class vcClass = NSClassFromString(controllerArray[i]);
        UIViewController *viewController = [vcClass new];
        viewController.title = titleArray[i];
        //        HMNagationController *naviVC = [[HMNagationController alloc] initWithRootViewController:viewController];
        [tabBarVC addChildViewController:viewController];
    }
    
    
    return tabBarVC;
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
