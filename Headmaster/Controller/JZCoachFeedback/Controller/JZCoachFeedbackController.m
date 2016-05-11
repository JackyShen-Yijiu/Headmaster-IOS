//
//  JZCoachFeedbackController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCoachFeedbackController.h"
#import "JZMailboxData.h"
#import "JZCoachFeedbackView.h"

@interface JZCoachFeedbackController ()<UITextFieldDelegate>
@property (nonatomic, weak) JZCoachFeedbackView *feedbackView;
///  回复文字框
@property (nonatomic, strong) UITextField *replyTextField;
///  回复view
@property (nonatomic, strong) UIView *replyView;
///  回复按钮
@property (nonatomic, strong) UIButton *replyButton;

///  分割线
@property (nonatomic, strong) UIView *lineView;





@end

@implementation JZCoachFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myNavigationItem.title = @"教练反馈";

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat feedbackViewHeight = [JZCoachFeedbackView coachFeedbackViewH:self.dataModel];
    
    JZCoachFeedbackView *feedbackView = [[JZCoachFeedbackView alloc]initWithFrame:CGRectMake(0,0, kJZWidth,feedbackViewHeight)];
    feedbackView.data = self.dataModel;
    self.feedbackView = feedbackView;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,kJZWidth,kJZHeight)];
    
    [self.view addSubview:contentScrollView];
    
    contentScrollView.contentSize = feedbackView.frame.size;
    
    [contentScrollView addSubview:feedbackView];

    [self setUI];
    
    
//    监听键盘frame将要发生变化时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:self.replyTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardEndChangeFrame:) name:UIKeyboardDidHideNotification object:self.replyTextField];

    
    self.replyTextField.delegate = self;
    
    [self.replyButton addTarget:self action:@selector(replyButtonClick) forControlEvents:UIControlEventTouchUpInside];

}

-(void)replyButtonClick {
    self.replyView.transform = CGAffineTransformIdentity;

    [NetworkEntity postCoachFeedbackWithparams:[UserInfoModel defaultUserInfo] ReplyContent:self.replyTextField.text feedbackID:self.dataModel._id success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

        NSString *data = response[@"data"];
        
        if (data) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"回复成功"];
        [alertView show];
            
        }else {
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"回复失败"];
            [alertView show];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
    
       
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"回复失败"];
            [alertView show];
        
    }];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    
    NSDictionary *keyboardDict = note.userInfo;
    
    CGRect keyboardFrame = [keyboardDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat tanslationY =  keyboardFrame.origin.y;
    
    // 出现
    self.replyView.transform = CGAffineTransformMakeTranslation(0, -tanslationY +64);
    

    
}
- (void)keyboardEndChangeFrame:(NSNotification *)note {

    // 隐藏
        self.replyView.transform = CGAffineTransformIdentity;

}
-(void)setUI {
    
    [self.replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@46);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.replyView.mas_top);
        
    }];
    
    
    [self.replyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-42);
        make.centerY.equalTo(self.replyView);
        make.height.equalTo(@32);
    }];
    
    [self.replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.replyTextField.mas_right).offset(12);
        make.centerY.equalTo(self.replyView.mas_centerY);
        make.height.equalTo(@18);
        make.width.equalTo(@18);
        
    }];
    
    

    
}
- (void)dealloc {
    // 把控制器从通知中心中移除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 懒加载
-(UIView *)replyView {
    
    if (!_replyView) {
        
        _replyView = [[UIView alloc]init];
        
        _replyView.backgroundColor = RGB_Color(247, 247, 247);
        [self.view addSubview:_replyView];
        
    }
    return _replyView;
}
-(UIView *)lineView {
    if (!_lineView) {
        
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = RGB_Color(206, 206, 206);
        
        [self.replyView addSubview:_lineView];
    }
    
    return _lineView;
}

-(UITextField *)replyTextField {
    
    if (!_replyTextField) {
        
        _replyTextField = [[UITextField alloc]init];
        _replyTextField.backgroundColor = [UIColor whiteColor];
        _replyTextField.font = [UIFont systemFontOfSize:14];
        _replyTextField.placeholder = @" 可在此处输入内容进行回复";
        _replyTextField.textColor = kJZDarkTextColor;
        _replyTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.replyView addSubview:_replyTextField];
    }
    return _replyTextField;
}
-(UIButton *)replyButton {
    
    if (!_replyButton) {
        
        
        _replyButton = [[UIButton alloc]init];
        [_replyButton setBackgroundImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
        
        [self.replyView addSubview:_replyButton];
    }
    return _replyButton;
}
@end
