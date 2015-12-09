//
//  AboutUsController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/6.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "AboutUsController.h"
#import "InformationDetailController.h"

@interface AboutUsController () {
    UIImageView *_iconView;
    UILabel  *_iconNameLabel;
    UILabel  *_descriptionLabel;
    UILabel  *_versionLabel;
    UIButton *_LicenseServiceAgreementBtn;
    UILabel  *_buttomLabel;
}

@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackgroundImage];
    [self initUI];
    [self configeUI];
    [self updataUI];
}

- (void)initUI {
    self.navigationItem.title = @"关于我们";
    
    CGRect backframe= CGRectMake(0, 0, 16, 16);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    _iconView = [[UIImageView alloc] init];
    [self.view addSubview:_iconView];
    
    _iconNameLabel = [[UILabel alloc] init];
    [self.view addSubview:_iconNameLabel];
    
    _descriptionLabel = [[UILabel alloc] init];
    [self.view addSubview:_descriptionLabel];
    
    _versionLabel = [[UILabel alloc] init];
    [self.view addSubview:_versionLabel];
    
    _LicenseServiceAgreementBtn = [[UIButton alloc] init];
    [self.view addSubview:_LicenseServiceAgreementBtn];
    
    _buttomLabel = [[UILabel alloc] init];
    [self.view addSubview:_buttomLabel];
}

- (void)pushBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)configeUI {
    _iconView.image = [UIImage imageNamed:@"jietu"];
    _iconView.layer.cornerRadius = 10;
    _iconView.clipsToBounds = YES;
    
    _iconNameLabel.text = @"一步学车";
    _iconNameLabel.textColor = [UIColor colorWithHexString:@"#fcfcfc"];
    _iconNameLabel.font = [UIFont systemFontOfSize:14];
    
    _descriptionLabel.text = @"做有态度的驾校培训";
    _descriptionLabel.textColor = [UIColor colorWithHexString:@"#fcfcfc"];
    _descriptionLabel.font = [UIFont systemFontOfSize:15];
    
    _versionLabel.text = @"v1.0.0";
    _versionLabel.textColor = [UIColor colorWithHexString:@"#fcfcfc"];
    _versionLabel.font = [UIFont systemFontOfSize:15];
    
    [_LicenseServiceAgreementBtn setTitle:@"许可服务协议" forState:UIControlStateNormal];
    [_LicenseServiceAgreementBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _LicenseServiceAgreementBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_LicenseServiceAgreementBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _buttomLabel.text = @"Copyright All Right Resrved";
    _buttomLabel.textColor = [UIColor colorWithHexString:@"#fcfcfc"];
}

- (void)btnClick {
    InformationDetailController *imdc = [[InformationDetailController alloc] init];
    imdc.urlStr = @"http://www.ifanying.com/userAgreement.html";
    [self.navigationController pushViewController:imdc animated:YES];
}

- (void)updataUI {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.mas_equalTo(150);
    }];
    
    [_iconNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_iconView.mas_bottom).offset(10);
    }];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_iconNameLabel.mas_bottom).offset(20);
    }];
    
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(_descriptionLabel.mas_bottom).offset(15);
    }];
    
    [_buttomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-20);
    }];
    
    [_LicenseServiceAgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(_buttomLabel.mas_top).offset(-15);
    }];
    
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