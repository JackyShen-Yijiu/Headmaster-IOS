//
//  JZPublishController.m
//  Headmaster
//
//  Created by 雷凯 on 16/4/18.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZPublishController.h"
#import "JZPublishHistoryController.h"

#define kLKSize [UIScreen mainScreen].bounds.size
@interface JZPublishController ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIBarButtonItem    *pushBtn;
@property (nonatomic, strong) UIBarButtonItem    *publishHistoryBtn;
///  顶部线
@property (nonatomic, weak) UIView *topView;

///  主标题
@property (nonatomic, weak) UITextField *mainTitleField;
///  内容的hoder占位提示符
@property (nonatomic, weak) UILabel *placeholderLabel;
///  内容
@property (nonatomic, weak) UITextView *contentTextView;
///  分割线
@property (nonatomic, weak) UIView *lineView;
///  发布按钮
@property (nonatomic, weak) UIButton *putButton;
///  半透明黑色遮罩
@property (nonatomic, weak) UIView *alphaView;
///  内容
@property (nonatomic, copy) NSString *contentText;
///  标题
@property (nonatomic, copy) NSString *mainTitle;

@end

@implementation JZPublishController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [NetworkTool cancelAllRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self layoutUI];
    
    self.contentTextView.delegate = self;
    self.mainTitleField.delegate = self;
    
    
    
    
    
}

-(void)initUI {
    
    self.title = @"发布公告";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"历史公告" style:UIBarButtonItemStyleDone target:self action:@selector(publishHistoryBtnClick)];
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIFont
                                                           boldSystemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    [self addBackgroundImage];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    self.topView = topView;
    [self.view addSubview:topView];
    
    
    UITextField *mainTitleField = [[UITextField alloc]init];
    mainTitleField.placeholder = @"请输入公告标题 最多15字（选填）";
    mainTitleField.font = [UIFont systemFontOfSize:14];
    if (YBIphone6Plus) {
        mainTitleField.font = [UIFont systemFontOfSize:14*YBRatio];
    }
    mainTitleField.textColor = [UIColor whiteColor];
    mainTitleField.tintColor = [UIColor whiteColor];
    [mainTitleField setValue:RGB_Color(185, 185, 185) forKeyPath:@"_placeholderLabel.textColor"];
    [mainTitleField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    if (YBIphone6Plus) {
        [mainTitleField setValue:[UIFont boldSystemFontOfSize:14*YBRatio] forKeyPath:@"_placeholderLabel.font"];
    }
    [self.view addSubview:mainTitleField];
    self.mainTitleField = mainTitleField;
    
    UIView *linView = [[UIView alloc]init];
    linView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    [self.view addSubview:linView];
    self.lineView = linView;
    
    
    UIView *alphaView = [[UIView alloc]init];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.1;
    [self.view addSubview:alphaView];
    self.alphaView = alphaView;
    
    
    
    UITextView *contentTextView = [[UITextView alloc]init];
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.textColor = [UIColor whiteColor];
    contentTextView.tintColor = [UIColor whiteColor];
    [self.view addSubview:contentTextView];
    self.contentTextView = contentTextView;
    
    UILabel *placeholderLabel = [[UILabel alloc]init];
    [placeholderLabel setFont:[UIFont systemFontOfSize:14]];
    placeholderLabel.text = @"公告仅对教练发布 最多300字";
    placeholderLabel.textColor = RGB_Color(185, 185, 185);
    self.placeholderLabel = placeholderLabel;
    [self.view addSubview:placeholderLabel];
    
    UIButton *putButton = [[UIButton alloc]init];
    putButton.titleLabel.textColor = [UIColor whiteColor];
    [putButton setTitle:@"发布" forState:UIControlStateNormal];
    [putButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    putButton.backgroundColor = RGB_Color(0, 248, 199);
    
    putButton.layer.masksToBounds = YES;
    putButton.layer.cornerRadius = 4;
    [self.view addSubview:putButton];
    self.putButton = putButton;
    [putButton addTarget:self action:@selector(putButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)layoutUI {
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@1);
        
        
    }];
    
    [self.mainTitleField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topView.mas_top);
        make.left.equalTo(self.view.mas_left).offset(28);
        make.right.equalTo(self.view.mas_right).offset(-28);
        make.height.equalTo(@60);
        
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainTitleField.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@1);
        
    }];
    
    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lineView.mas_bottom).offset(16);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@274);
        
        
    }];
    
    
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.alphaView).offset(12);
        make.left.equalTo(self.alphaView).offset(12);
        make.right.equalTo(self.alphaView).offset(-12);
        make.bottom.equalTo(self.alphaView).offset(-12);
        
    }];
    
    
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentTextView.mas_left);
        make.right.equalTo(self.contentTextView.mas_right);
        make.top.equalTo(self.contentTextView.mas_top);
        make.height.equalTo(@14);
        
    }];
    
    [self.putButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.alphaView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.equalTo(@44);
        
    }];
    
    
}

#pragma mark - 发布按钮点击事件
-(void)putButtonClick {
    
    
    NSLog(@"点击了putButtonClick putButtonClick putButtonClick putButtonClick ");
    if ([self.contentTextView.text isEqualToString:@""]) {
        
        [self showTotasViewWithMes:@"输入内容不可为空"];
    }else if (self.contentTextView.text.length >=300 ){
    
        [self showTotasViewWithMes:@"公告内容最多输入300字"];
    } else {
        
        
        [self needPublishMessageWithContentText:self.contentTextView.text WithMainTitle:self.mainTitleField.text];
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }];
    }
    
    
    
    
}


#pragma mark - 发布的网络请求
- (void)needPublishMessageWithContentText:(NSString *)contentText WithMainTitle:(NSString *)mainTitle {
    
    [NetworkEntity postPublishMessageWithUseInfoModel:[UserInfoModel defaultUserInfo] textContent:contentText mainTitle:mainTitle success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:[dataDic objectForKey:@"data"]];
        [alertView show];
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:[dataDic objectForKey:@"msg"]];
        [alertView show];
        
        
    }];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    self.view.transform = CGAffineTransformMakeTranslation(0,-71);
    [self.contentTextView becomeFirstResponder];
    
    self.placeholderLabel.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.view.transform = CGAffineTransformMakeTranslation(0,0);
    
    [self.contentTextView resignFirstResponder];
    
    if ([textView.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [self.contentTextView resignFirstResponder];
        self.view.transform = CGAffineTransformMakeTranslation(0,0);
        return NO;
    }
    
    
    if (range.location>=300) {
        self.view.transform = CGAffineTransformMakeTranslation(0,0);
        [self showTotasViewWithMes:@"公告内容最多输入300字"];

        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.placeholderLabel.hidden = YES;
    self.placeholderLabel.text = @"";
    
    
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.placeholderLabel.hidden = YES;
    

        [self.mainTitleField becomeFirstResponder];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    [self.contentTextView resignFirstResponder];
 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.contentTextView resignFirstResponder];

    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if ([string isEqualToString:@"\n"]) {
        
        [self.contentTextView resignFirstResponder];
        
        return NO;
    }
    
    
    if (range.location>=15) {
        [self showTotasViewWithMes:@"公告标题最多输入15字"];
        [self.contentTextView resignFirstResponder];
        return NO;
    }
    return YES;

}



#pragma mark - 顶部左侧按钮事件
- (void)pushBtnClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 顶部右侧跳转到历史公告按钮点击事件
-(void)publishHistoryBtnClick {
    
    JZPublishHistoryController *historyVC = [[JZPublishHistoryController alloc]init];
    
    [self.navigationController pushViewController:historyVC animated:YES];
    
}
#pragma mark - 背景图片
- (void)addBackgroundImage {
    
    UIImage *image = [UIImage imageNamed:@"controllerBackground"];
    self.view.layer.contents = (id)image.CGImage;
}
#pragma mark - lazy
- (UIBarButtonItem *)pushBtn {
    if (!_pushBtn) {
        CGRect backframe= CGRectMake(0, 0, 16, 16);
        UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = backframe;
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _pushBtn;
}
@end
