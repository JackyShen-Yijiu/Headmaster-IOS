//
//  FeedbackController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "FeedbackController.h"
#import "NSString+Helper.h"

@interface FeedbackController () <UITextViewDelegate> {
    UITextView *_textview;
    UILabel    *_placeholderLabel;
}

@end

@implementation FeedbackController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 0, self.view.bounds.size.width - 15, 2)];
//    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
//    [self.view addSubview:lineTopView];
    [self addBackgroundImage];
    [self initUI];
}

- (void)initUI {
    self.navigationItem.title = @"意见反馈";
    
    CGRect backframe= CGRectMake(0, 0, 16, 16);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    
    _textview = [[UITextView alloc] init];

    _textview.backgroundColor = [UIColor whiteColor];
//    _textview.alpha = 0.5;
    _textview.textColor = kJZDarkTextColor;
    _textview.delegate = self;
    _textview.layer.borderColor = kJZLightTextColor.CGColor;
    _textview.layer.borderWidth = 0.5;
    _textview.layer.cornerRadius = 3;
    _textview.layer.masksToBounds = YES;
    [self.view addSubview:_textview];
    
    [_textview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(12);
        make.top.equalTo(self.view.mas_top).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@218);
        
    }];
    
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.text = @"您对极致驾服有什么建议或反馈";
    _placeholderLabel.font = [UIFont systemFontOfSize:14];
    if (YBIphone6Plus) {
        _placeholderLabel.font = [UIFont systemFontOfSize:14*YBRatio];
    }
    _placeholderLabel.textColor = kJZLightTextColor;
    [self.view addSubview:_placeholderLabel];
    
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_textview.mas_left).offset(12);
        
        make.top.equalTo(_textview.mas_top).offset(12);
        
    }];

    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor = JZ_BLUE_COLOR;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(12);
        make.top.equalTo(_textview.mas_bottom).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@44);
        
    }];
}

- (void)pushBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnClick {
    [_textview resignFirstResponder];
    
    if ([[_textview.text trimString] isEqualToString:@""]) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请您填写完反馈内容后再反馈!"];
        [toastView show];
        return ;
    }
    //手机版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    //分辨率为宽高*scale
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    //当前版本信息
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSDictionary *params =@{
                            @"userid":[UserInfoModel defaultUserInfo].userID,
                            @"feedbackmessage": _textview.text,
                            @"mobileversion":[NSString stringWithFormat:@"IOS %@",phoneVersion],
                            @"network":[self networktype],
                            @"resolution":[NSString stringWithFormat:@"%f*%f",size_screen.width*scale_screen,size_screen.height*scale_screen],
                            @"appversion":[NSString stringWithFormat:@"IOS %@",appCurVersion]
                            };
    NSLog(@"%@",params);
    [NetworkEntity postFeedbackWithparams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         [self.navigationController popToRootViewControllerAnimated:YES];
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"我们以收到您的反馈，谢谢您的宝贵意见"];
        [alertView show];
    
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"反馈失败，请检查网络连接"];
        [alertView show];
    }];
    _textview.text = @"";
    _placeholderLabel.hidden = NO;
}

//当前网络状态
-(NSString *)networktype{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }

    if ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue] == 0) {
        return @"无服务";
    }else if ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue] == 1) {
        return @"2G";
    }else if ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue] == 2) {
        return @"3G";
    }else if ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue] == 3) {
        return @"4G";
    }else if ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue] == 4) {
        return @"LTE";
    }else if ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue] == 5) {
        return @"Wifi";
    }else {
        return @"";
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([_textview.text isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
        
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeholderLabel.hidden = NO;
    }
    if (range.location>=300) {
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
