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
//    UIView *_lineViewUP;
    UIImageView *_passwordView;
    UIView *_downView;
//    UIView *_lineViewDown;
    UIButton *_loginButton;
    UIButton *_callBtn;
    UIView *_phoneAndPasswordBG;
//    UIView *_bottomLineView;
}

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *BJView;



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
//    _iconView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_iconView];
    
    
    self.BJView = [[UIView alloc]init];
    self.BJView.backgroundColor = kJZLightTextColor;
    self.BJView.layer.cornerRadius = 3;
    self.BJView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.BJView];
    
    self.lineView = [[UIView alloc]init];
    
    self.lineView.backgroundColor = kJZLightTextColor;
    
    
    [self.view addSubview:self.lineView];
    

    
    _phoneAndPasswordBG = [[UIView alloc] init];
    _phoneAndPasswordBG.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    _phoneAndPasswordBG.layer.cornerRadius = 3;
    _phoneAndPasswordBG.layer.masksToBounds = YES;
    
//    _phoneAndPasswordBG.alpha = 0.1;
    [self.BJView addSubview:_phoneAndPasswordBG];
    
    _phoneTF = [[UITextField alloc] init];           //账号输入框
    _phoneTF.backgroundColor = RGBA_Color(255, 255, 255, 0.72);
    _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_phoneAndPasswordBG addSubview:_phoneTF];
    
    _upView = [[UIView alloc] init];                 //账号输入框左侧的父视图
    _phoneTF.leftView = _upView;
    
    _phoneView = [[UIImageView alloc]init];          //账号输入框的icon
    [_upView addSubview:_phoneView];

    
    _passwordTF = [[UITextField alloc] init];
    _passwordTF.backgroundColor = RGBA_Color(255, 255, 255, 0.72);
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;//密码输入框
    [_phoneAndPasswordBG addSubview:_passwordTF];
    
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
    
    
    
}

- (void)updateUI {
    
    
    _BackgroundImage.frame = self.view.bounds;
    
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.mas_top).offset(84);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@96);
        make.width.equalTo(@78);
        
    }];
    
    
    
    [_phoneAndPasswordBG mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_iconView.mas_bottom).offset(68);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@88.5);

    }];
    
    [self.BJView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_iconView.mas_bottom).offset(67.5);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(15.5);
        make.right.equalTo(self.view.mas_right).offset(-15.5);
        make.height.equalTo(@89.5);
        
    }];
    


    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_iconView.mas_bottom).offset(68);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@44);
        
    }];
    
    _phoneView.frame        = CGRectMake(8,6,16 , 16);
    _upView.frame           = CGRectMake(0, 0, 32,32);
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_phoneTF.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@0.5);

        
    }];
    
    

    
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneTF.mas_bottom).offset(0.5);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@44);
        
    }];
    
    _passwordView.frame     = CGRectMake(8,6,16 , 16);
    

    
    _downView.frame         = CGRectMake(0,0, 32, 32);
    

    
//    _lineViewDown.frame     = CGRectMake(0, _passwordTF.frame.origin.y +h_phoneTFHeight , h_size.width, 1);

    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_passwordTF.mas_bottom).offset(16);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@44);
        
    }];
    
    
    [_callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_loginButton.mas_bottom).offset(18);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    

    
   }

- (void)configeUI {
    _BackgroundImage.image = [UIImage imageNamed:@"background.jpg"];
    
//    _iconView.contentMode = UIViewContentModeCenter;
    _iconView.image = [UIImage imageNamed:@"logo.jpg"];
    
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.textColor = kJZDarkTextColor;
    [_phoneTF setValue:kJZLightTextColor forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    if (YBIphone6Plus) {
        [_phoneTF setValue:[UIFont systemFontOfSize:14*YBRatio] forKeyPath:@"_placeholderLabel.font"];
    }
    _phoneTF.delegate = self;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    _phoneView.image = [UIImage imageNamed:@"user"];
    [_phoneView sizeToFit];

    _upView.backgroundColor = [UIColor clearColor];
    
//    _lineViewUP.backgroundColor = kJZLightTextColor;
//    _lineViewUP.alpha = 0.1;
    
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.textColor = kJZDarkTextColor;
    [_passwordTF setValue:kJZLightTextColor forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    if (YBIphone6Plus) {
        [_passwordTF setValue:[UIFont systemFontOfSize:14*YBRatio] forKeyPath:@"_placeholderLabel.font"];
    }
    _passwordTF.delegate = self;
    _passwordTF.secureTextEntry = YES;
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    _passwordView.image = [UIImage imageNamed:@"key"];
    
    [_passwordView sizeToFit];
    
    _downView.backgroundColor = [UIColor clearColor];
    
//    _lineViewDown.backgroundColor = [UIColor clearColor];
//    _lineViewDown.alpha = 0.1;
    
    _loginButton.backgroundColor =JZ_BLUE_COLOR;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:20];
    if (YBIphone6Plus) {
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:20*YBRatio];
    }
    [_loginButton setTitleColor:[UIColor colorWithHexString:@"#fefefe"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(buttonIsClick) forControlEvents:UIControlEventTouchUpInside];
    
    _loginButton.layer.cornerRadius = 3;
    _loginButton.layer.masksToBounds = YES;
    
    [_callBtn setTitle:@"没有账号?联系我们" forState:UIControlStateNormal];
    _callBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (YBIphone6Plus) {
        _callBtn.titleLabel.font = [UIFont systemFontOfSize:14*YBRatio];
    }
    [_callBtn setTitleColor:JZ_BLUE_COLOR forState:UIControlStateNormal];
    [_callBtn addTarget:self action:@selector(callNum) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _iconView.hidden = YES;
    textField.placeholder = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    _iconView.hidden = NO;

    if ([_passwordTF.text isEqualToString:@""]) {
        _passwordTF.placeholder = @"请输入密码";
    }
    if ([_phoneTF.text isEqualToString:@""]) {
        _phoneTF.placeholder = @"请输入手机号";
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
            
            // 环信登录
            BOOL isLoggedIn = [[EaseMob sharedInstance].chatManager isLoggedIn];
            
            if (isLoggedIn) {
                [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:nil];
                
                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
                
                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                    
                } onQueue:nil];
                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                    
                    if (!error && info) {
                    }
                } onQueue:nil];
            }
            
            NSString *headerid = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"userid"]];
            
            // 异步登陆账号
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:headerid
                                                                password:[_passwordTF.text MD5Digest]
                                                              completion:
             ^(NSDictionary *loginInfo, EMError *error) {
                 
                 NSLog(@"环信登陆loginInfo:%@ error:%@",loginInfo,error);
                 
                 [MBProgressHUD hideHUDForView:self.view animated:NO];
                 
                 if (loginInfo && !error) {
                     
                     
                     // 基本数据保存
                     NSMutableDictionary * loginInfo = [responseObject mutableCopy];
                     
                     [NetworkTool setHTTPHeaderField:[[loginInfo objectForKey:@"data"] objectForKey:@"token"]];
                     
                     [loginInfo setValue:[_passwordTF.text MD5Digest]forKey:@"md5Pass"];
                     
                     [[UserInfoModel defaultUserInfo] loginViewDic:loginInfo];
                     
                     // 发送侧边栏个人信息改变通知
                     [[NSNotificationCenter defaultCenter] postNotificationName:sideMenuInfochange object:nil];
                     
                     
                     [[MenuController defaultImageView] sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait]];
                     
                     
                     //友盟账号统计
                     [MobClick profileSignInWithPUID:_phoneTF.text];

                     //极光推送设置alias
                     [APService setAlias:[UserInfoModel defaultUserInfo].userID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                     
                     
                     // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
                     EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
                     if (!error) {
                         //获取数据库中数据
                         error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                     }
                     
                     //                    [[EaseMob sharedInstance].chatManager removeAllConversationsWithDeleteMessages:YES append2Chat:NO];
                     
                     // 设置自动登录
                     [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                     

                     [[NSNotificationCenter defaultCenter] postNotificationName:longinSuccess object:self];
//                     if ([self.delegate respondsToSelector:@selector(loginControllerDidLoginSucess:)]) {
//                         [self.delegate loginControllerDidLoginSucess:self];
//                     }

                    
                     
                 }
                 else
                 {
                     
                     
                     [self showTotasViewWithMes:error.description];
//                     ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:error.description controller:self];
//                     [alerview show];
                     
                 }
                 
             } onQueue:nil];
            

                     
//            [[EaseMob sharedInstance].chatManager removeAllConversationsWithDeleteMessages:YES append2Chat:NO];

                    }else {
                        [self showTotasViewWithMes:[responseObject objectForKey:@"msg"]];
   
                        
//            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:[responseObject objectForKey:@"msg"]];
//            [toastView show];
        }
    } failure:^(NSError *failure) {
        
        [self showTotasViewWithMes:@"网络连接失败"];
//        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络连接失败"];
//        [toastView show];
    }];

}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)callNum {
    
//    NSLog(@"测试测试测试测试测试测试测试测试测试测试测试");
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://400-101-6669"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (UIViewController *)rootViewController {
    
    NSArray *controllerArray = @[ @"HomeController",
                                  @"JZInformationController",
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

}



@end
