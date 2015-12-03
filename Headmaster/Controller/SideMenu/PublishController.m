//
//  PublishController.m
//  Headmaster
//
//  Created by 胡东苑 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PublishController.h"
#import "PublishCell.h"
#import "RefreshTableView.h"
#import "NetworkInterface.h"

#define USERINFO_IDENTIFY       @"USERINFO_IDENTIFY"
#define h_size [UIScreen mainScreen].bounds.size

@interface PublishController () <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate> {
    NSMutableArray *_dataArr;
    UITextView *_tv;
    UILabel *_placeholderLabel;
    int _isCoachBtn;   //1表示学员 2表示教练
}

@property (nonatomic, strong) UITableView        *tableView;

@property (nonatomic, strong) NSMutableArray     *dataArr;

@property (nonatomic, strong) UIBarButtonItem    *publishBtn;

@property (nonatomic, strong) UIBarButtonItem    *pushBtn;

@property (nonatomic, strong) UIButton           *coachBtn;

@property (nonatomic, strong) UIButton           *studentBtn;


@end

@implementation PublishController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = self.publishBtn;
    
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    
}

- (void)pushBtnClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishBtnClick {
    [_tv resignFirstResponder];
    [NetworkEntity postPublishMessageWithUseInfoModel:[UserInfoModel defaultUserInfo] textContent:_tv.text type:[NSString stringWithFormat:@"%d",_isCoachBtn] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"++++++++++%@",responseObject);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"%@",[dataDic objectForKey:@"msg"]);
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"发表成功"];
        [alertView show];
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"发表失败"];
        [alertView show];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    _isCoachBtn = 1;
    [self createUI];
    [self startConnection];
}

- (void)createUI {
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"如果你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦爱因斯坦爱因斯坦如果你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦你无法简洁的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦爱因斯坦爱因",@"如果你无法简洁的表达你的想法，那只爱因斯坦爱因斯坦爱因爱因斯坦爱因斯坦爱因说明你还不够了解它，阿尔伯爱因斯坦爱因斯坦爱因爱因斯坦爱因斯坦爱因爱因斯坦爱因斯坦爱因特。爱因斯坦爱因斯坦爱因斯坦爱因",@"如果你无法简洁的爱因斯坦爱因斯坦爱因表达你的表达你的想法，那只说明你还不够了解它，阿尔伯特。爱因斯坦", nil];
    
    [self.view addSubview:self.tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PublishCell" bundle:nil] forCellReuseIdentifier:@"yy"];
    UIView *view = [[UIView alloc] init];
    _tableView.tableFooterView = view;
    
//    [self initRefreshView];
}

- (void)startConnection {
    
    [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo] seqindex:[NSString stringWithFormat:@"%d",0] count:[NSString stringWithFormat:@"%d",10] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"__________%@",dataDic);
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"网络连接失败");
    }];
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, h_size.width, h_size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UIBarButtonItem *)publishBtn {
    if (!_publishBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [button setTitle:@"发布" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _publishBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _publishBtn;
}

- (UIBarButtonItem *)pushBtn {
    if (!_pushBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _pushBtn;
}
     


#pragma mark - refresh

- (void)initRefreshView
{

//    WS(ws);
//    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
//        
//        
//        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
//        [NetWorkEntiry getTeacherListWithSchoolId:type pageIndex:1 success:^(id responseObject) {
//            
//            if (type == 1) {
//                ws.tableViewData = [[BaseModelMethod getTeacherListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [ws.tableView.refreshHeader endRefreshing];
//                    [ws.tableView reloadData];
//                });
//            }
//            
//        } failure:^(NSError *failure) {
//            [ws netErrorWithTableView:ws.tableView];
//        }];
//        
//    };
//    
//    self.tableView.refreshFooter.beginRefreshingBlock = ^(){
//        
//        
//        [NetWorkEntiry getTeacherListWithSchoolId:@"56163c376816a9741248b7f9" pageIndex:ws.tableViewData.count / RELOADDATACOUNT + 1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
//            
//            if (type == 1) {
//                NSArray * listArray = [[BaseModelMethod getTeacherListArrayFormDicInfo:[responseObject objectArrayForKey:@"data"]] mutableCopy];
//                if (listArray.count) {
//                    [ws.tableViewData addObjectsFromArray:listArray];
//                    [ws.tableView reloadData];
//                }else{
//                    [ws showTotasViewWithMes:@"已经加载所有数据"];
//                }
//                [ws.tableView.refreshFooter endRefreshing];
//            }else{
//                [ws dealErrorResponseWithTableView:ws.tableView info:responseObject];
//            }
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [ws netErrorWithTableView:ws.tableView];
//        }];
//        
//    };
}



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
