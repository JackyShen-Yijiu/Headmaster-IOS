//
//  FeedbackController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "FeedbackController.h"

@interface FeedbackController () <UITextViewDelegate> {
    UITextView *_textview;
    UILabel    *_placeholderLabel;
}

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.frame = CGRectMake(2, 6, 200, 30);
    _placeholderLabel.text = @"请留下宝贵意见和建议";
    _placeholderLabel.font = [UIFont systemFontOfSize:15];
    _placeholderLabel.textColor = [UIColor grayColor];
    [self.view addSubview:_placeholderLabel];
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 6, self.view.frame.size.width, 100)];
    _textview.backgroundColor = [UIColor blackColor];
    _textview.alpha = 0.5;
    _textview.textColor = [UIColor colorWithHexString:TEXT_HIGHLIGHT_COLOR];
    _textview.delegate = self;
    _textview.layer.borderColor = [UIColor blackColor].CGColor;
    _textview.layer.borderWidth = 1;
    [self.view addSubview:_textview];
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 111, self.view.frame.size.width-20, 40)];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor orangeColor];
    [submitBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

- (void)btnClick {
    [_textview resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = YES;
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
