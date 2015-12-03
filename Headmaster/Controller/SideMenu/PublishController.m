//
//  PublishController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PublishController.h"
#import "PublishCell.h"

#define h_size [UIScreen mainScreen].bounds.size

@interface PublishController () <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate> {
    NSMutableArray *_dataArr;
    UITextView *_tv;
    UILabel *_placeholderLabel;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PublishController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
    
    UIButton *pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [pushBtn setTitle:@"返回" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pushBtn];
    
    
}

- (void)pushBtnClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishBtnClick {
    [_tv resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createUI];
    
}

- (void)createUI {
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"如果你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦爱因斯坦爱因斯坦如果你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦爱因斯坦爱因",@"如果你无法简洁的表达你的想法，那只爱因斯坦爱因斯坦爱因爱因斯坦爱因斯坦爱因说明你还不够了解它，阿尔伯爱因斯坦爱因斯坦爱因爱因斯坦爱因斯坦爱因爱因斯坦爱因斯坦爱因特。爱因斯坦爱因斯坦爱因斯坦爱因",@"如果你无法简洁的爱因斯坦爱因斯坦爱因表达你的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦", nil];
    
    [self.view addSubview:self.tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PublishCell" bundle:nil] forCellReuseIdentifier:@"yy"];
    UIView *view = [[UIView alloc] init];
    _tableView.tableFooterView = view;
    
    
}

#pragma mark ---lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, h_size.width, h_size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

#pragma mark ----refresh


#pragma mark Load Data


#pragma mark ----tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }else {
        NSString *str = _dataArr[indexPath.row -1
                                 ];
        CGSize size = [str boundingRectWithSize:CGSizeMake(h_size.width - 16 -1 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil].size;
        return 50+size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dy"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"dy"];
        }
        UIButton *coachBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 60, 30)];
        [coachBtn setTitle:@"教练" forState:UIControlStateNormal];
        [coachBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:coachBtn];
        
        UIButton *studentBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 5, 60, 30)];
        [studentBtn setTitle:@"学员" forState:UIControlStateNormal];
        [studentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:studentBtn];
        
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 30)];
        _placeholderLabel.text = @"最多输入300字";
        _placeholderLabel.font = [UIFont systemFontOfSize:15];
        
        _placeholderLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:_placeholderLabel];
        
        _tv = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, h_size.width-20, 150)];
        _tv.backgroundColor = [UIColor clearColor];
        _tv.delegate = self;
        _tv.layer.borderColor = [UIColor blackColor].CGColor;
        _tv.layer.borderWidth = 1;
        [cell.contentView addSubview:_tv];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
        
        cell.deleteCell = ^{
            [_dataArr removeObjectAtIndex:indexPath.row-1];
            [tableView reloadData];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentLabel.text = _dataArr[indexPath.row-1];
        [cell adaptHeightWithString:_dataArr[indexPath.row-1]];
        return cell;
    }
}

#pragma mark ----textViewDelegate

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
