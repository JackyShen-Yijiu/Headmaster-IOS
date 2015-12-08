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
#import "PublishViewModel.h"
#import "BaseModelMethod.h"

#define h_size [UIScreen mainScreen].bounds.size

@interface PublishController () <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate> {
    NSMutableArray *_dataArr;
    UITextView *_tv;

    int _isCoachBtn;   //1表示学员 2表示教练
}

@property (nonatomic, strong) RefreshTableView   *tableView;

@property (nonatomic, strong) NSMutableArray     *dataArr;

@property (nonatomic, strong) UIBarButtonItem    *publishBtn;

@property (nonatomic, strong) UIBarButtonItem    *pushBtn;

@property (nonatomic, strong) UIButton           *coachBtn;

@property (nonatomic, strong) UIButton           *studentBtn;

@property (nonatomic, strong) PublishViewModel   *viewModel;

@property (nonatomic, assign) int                seqindex;

@property (nonatomic, strong) UILabel            *placeholderLabel;

@property (nonatomic, strong) UITextView         *tv;

@end

@implementation PublishController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.rightBarButtonItem = self.publishBtn;
    self.navigationItem.leftBarButtonItem = self.pushBtn;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addBackgroundImage];
    _isCoachBtn = 2;
    [self createUI];
    _viewModel = [PublishViewModel new];
    WS(ws);
    _viewModel.refreshBlock = ^{
        [ws.tableView.refreshHeader beginRefreshing];
    };
    [_viewModel successRefreshBlock:^{
        NSLog(@"我被成功回调了哟！");
        PublishDataModel *dataModel = [_viewModel.publishData lastObject];
        self.seqindex = [dataModel.seqindex intValue];
        [self.tableView reloadData];
    }];
    [_viewModel errorLoadMoreBlock:^{
        [self netErrorWithTableView:_tableView];
    }];
    [_viewModel networkRequestRefresh];
    [self initRefreshView];
}

- (void)createUI {
    [self.view addSubview:self.tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PublishCell" bundle:nil] forCellReuseIdentifier:@"yy"];
    UIView *view = [[UIView alloc] init];
    _tableView.tableFooterView = view;
}

#pragma mark - lazy load

- (RefreshTableView *)tableView {
    if (!_tableView) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UIButton *)coachBtn {
    if (!_coachBtn) {
        _coachBtn = [[UIButton alloc] init];
        self.coachBtn.frame = CGRectMake(32, 10, 60, 19);
        [self.coachBtn setTitle:@"教练" forState:UIControlStateNormal];
        [_coachBtn setTitleColor:[UIColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
        [_coachBtn setImage:[[UIImage imageNamed:@"x42x43"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
        _coachBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,41);
        _coachBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -25,0 , 0);
    }
    return _coachBtn;
}

- (UIButton *)studentBtn {
    if (!_studentBtn) {
        _studentBtn = [[UIButton alloc] init];
        self.studentBtn.frame = CGRectMake(120, 10, 60, 19);
        [self.studentBtn setTitle:@"学员" forState:UIControlStateNormal];
        [_studentBtn setTitleColor:[UIColor colorWithHexString:@"047a64"] forState:UIControlStateNormal];
        [_studentBtn setImage:[[UIImage imageNamed:@"m42x43"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
        _studentBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,41);
        _studentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -25,0, 0);
        _studentBtn.backgroundColor = [UIColor clearColor];
    }
    return _studentBtn;
}

- (UITextView *)tv {
    if (!_tv) {
        _tv = [[UITextView alloc] init];
        _tv.backgroundColor = [UIColor blackColor];
        _tv.alpha = 0.5;
//        _tv.textColor = [UIColor colorWithHexString:@"#fcfcfc"];
        _tv.textColor = [UIColor whiteColor];
    }
    return _tv;
}


- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
    }
    return _placeholderLabel;
}

- (UIBarButtonItem *)publishBtn {
    if (!_publishBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [button setTitle:@"发布" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:TEXT_HIGHLIGHT_COLOR] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _publishBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _publishBtn;
}

- (UIBarButtonItem *)pushBtn {
    if (!_pushBtn) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:TEXT_HIGHLIGHT_COLOR] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _pushBtn;
}

- (void)shuaxinlala {
    [self.tableView.refreshHeader beginRefreshing];
}

#pragma mark - refresh

- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [self showTotasViewWithMes:@"已经加载所有数据"];
    [tableview.refreshHeader endRefreshing];
    [tableview.refreshFooter endRefreshing];
}

- (void)netErrorWithTableView:(RefreshTableView*)tableView
{
    [self showTotasViewWithMes:@"网络异常，稍后重试"];
    [tableView.refreshHeader endRefreshing];
    [tableView.refreshFooter endRefreshing];
}

- (void)initRefreshView
{
    WS(ws);
    __weak typeof(_viewModel) viewModel = _viewModel;
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo] seqindex:[NSString stringWithFormat:@"0"] count:[NSString stringWithFormat:@"10"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSInteger type = [[dataDic objectForKey:@"type"] integerValue];
            if (type == 1) {
                if ([[dataDic objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                    [ws showTotasViewWithMes:@"发布成功"];
                } else {
                    viewModel.publishData = [[BaseModelMethod getPublishListArrayFormDicInfo:[dataDic objectArrayForKey:@"data"]] mutableCopy];
                }
                [ws.tableView.refreshHeader endRefreshing];
                [ws.tableView reloadData];
            }
        } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
            [ws netErrorWithTableView:ws.tableView];
        }];
        [ws.tableView reloadData];
    };

    self.tableView.refreshFooter.beginRefreshingBlock = ^(){
        [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo] seqindex:[NSString stringWithFormat:@"%d",ws.seqindex] count:[NSString stringWithFormat:@"10"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSInteger type = [[dataDic objectForKey:@"type"] integerValue];
            if (type == 1 && ws.seqindex != 0) {
                NSMutableArray * listArray = [[BaseModelMethod getPublishListArrayFormDicInfo:[dataDic objectArrayForKey:@"data"]] mutableCopy];
                PublishDataModel *dataModel = [listArray lastObject];
                
                ws.seqindex = [dataModel.seqindex intValue];
                
                if (listArray.count) {
                    [viewModel.publishData addObjectsFromArray:listArray];
                    [ws.tableView reloadData];
                }else{
                    [ws showTotasViewWithMes:@"已经加载所有数据"];
                }
                dispatch_async(dispatch_get_main_queue(), ^{

                    [ws.tableView.refreshFooter endRefreshing];
                });
                
                
            }else{
                [ws dealErrorResponseWithTableView:ws.tableView info:dataDic];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
            [ws netErrorWithTableView:ws.tableView];
        }];
    };
}



#pragma mark Load Data


#pragma mark ----tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }else {
        PublishDataModel *dataModel = _viewModel.publishData[indexPath.row-1];
        NSString *contentStr = dataModel.content;

        CGSize size = [contentStr boundingRectWithSize:CGSizeMake(h_size.width - 16 -1 , CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil].size;
        return 45+size.height;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.publishData.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dy"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"dy"];
            cell.backgroundColor = [UIColor clearColor];
        }
        [self.coachBtn addTarget:self action:@selector(coachBtnIsClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.coachBtn];
        
        [self.studentBtn addTarget:self action:@selector(sutdentBtnIsClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:self.studentBtn];
        
        self.placeholderLabel.frame = CGRectMake(20, 40, 200, 30);
        self.placeholderLabel.text = @"最多输入300字";
        self.placeholderLabel.font = [UIFont systemFontOfSize:15];
        
        self.placeholderLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:self.placeholderLabel];
        
        self.tv.frame = CGRectMake(10, 40, h_size.width-20, 150);
        self.tv.delegate = self;
        self.tv.layer.borderColor = [UIColor blackColor].CGColor;
        self.tv.layer.borderWidth = 1;
        [cell.contentView addSubview:self.tv];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
        cell.backgroundColor = [UIColor clearColor];
        cell.deleteCell = ^{
            [_viewModel.publishData removeObjectAtIndex:indexPath.row-1];
            [tableView reloadData];
        };
        PublishDataModel *dataModel = _viewModel.publishData[indexPath.row-1];
        [cell refreshData:dataModel];
        return cell;
    }
}

#pragma mark ----textViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholderLabel.hidden = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqualToString:@""]) {
        self.placeholderLabel.hidden = YES;
        
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        self.placeholderLabel.hidden = NO;
    }
    if (range.location>=300) {
        return NO;
    }
    return YES;
}

#pragma marl - buttonClick

- (void)coachBtnIsClick {
    _isCoachBtn = 2;
    [self changePNG];
}

- (void)sutdentBtnIsClick {
    _isCoachBtn = 1;
    [self changePNG];
}

- (void)changePNG {
    if (_isCoachBtn == 2) {
        [_coachBtn setImage:[[UIImage imageNamed:@"x42x43"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
        [_studentBtn setImage:[[UIImage imageNamed:@"m42x43"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
    }else {
        [_coachBtn setImage:[[UIImage imageNamed:@"m42x43"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
        [_studentBtn setImage:[[UIImage imageNamed:@"x42x43"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
    }
}

- (void)pushBtnClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishBtnClick {
    [_tv resignFirstResponder];
    [_viewModel needPublishMessageWithContentStr:_tv.text WithType:[NSString stringWithFormat:@"%d",_isCoachBtn]];
    _tv.text = @"";
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_tv resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NetworkTool cancelAllRequest];
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
