//
//  JZMailBoxController.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMailBoxController.h"
#import "JZMailBoxView.h"
#import "JZMailBoxHeaderView.h"
#import "JZPublishHistoryController.h"
#import "JZPublishHistoryData.h"
#import <YYModel.h>

@interface JZMailBoxController ()
@property (nonatomic, strong) JZMailBoxView *mailboxView;
@property (nonatomic, strong) JZMailBoxHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *listDataArray;
@end

@implementation JZMailBoxController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    self.myNavigationItem.title = @"信箱";
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (YBIphone6Plus) {
        self.headerView = [[JZMailBoxHeaderView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, 55.2)];
        
    }else {
        self.headerView = [[JZMailBoxHeaderView alloc]initWithFrame:CGRectMake(0, 0, kJZWidth, 48)];

    }
    
 
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tapGestureTel];
    if (YBIphone6Plus) {
        self.mailboxView = [[JZMailBoxView alloc]initWithFrame:CGRectMake(0, 55.2, kJZWidth, kJZHeight-55.2-64) style:UITableViewStyleGrouped];
 
    }else {
        self.mailboxView = [[JZMailBoxView alloc]initWithFrame:CGRectMake(0, 48, kJZWidth, kJZHeight-48-64) style:UITableViewStyleGrouped];

    }
    
    self.mailboxView.vc = self;
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.mailboxView];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger messageCount =  [userDefaults integerForKey:@"JZPublishHistoryMessageCount"];
    
    JZPublishHistoryData *dataModel = self.listDataArray.firstObject;
    
        if (messageCount< dataModel.seqindex) {

          rightLabel.text =  [NSString stringWithFormat:@"%zd",dataModel.seqindex - messageCount];
            rightLabel.hidden = NO;
        }else {
            rightLabel.hidden = YES;
        }

    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.backgroundColor = [UIColor redColor];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = [UIFont systemFontOfSize:8];
    rightLabel.frame = CGRectMake(kJZWidth-44, 16, 16, 16);

    if (YBIphone6Plus) {
        rightLabel.font = [UIFont systemFontOfSize:8*YBRatio];
        rightLabel.frame = CGRectMake(kJZWidth-44*YBRatio, 16*YBRatio, 16*YBRatio, 16*YBRatio);

    }
    rightLabel.layer.masksToBounds = YES;
    rightLabel.layer.cornerRadius = rightLabel.width/2;
    
    [self.view addSubview:rightLabel];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [NetworkTool cancelAllRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}
#pragma mark - headerView点击事件
-(void)headerViewClick:(UITapGestureRecognizer *)recognizer {
    
    JZPublishHistoryController *publishVC = [[JZPublishHistoryController alloc]init];
    
    [self.myNavController pushViewController:publishVC animated:YES];
    
    
}

-(void)loadData {
    
    
    [NetworkEntity getPublishListWithUseInfoModel:[UserInfoModel defaultUserInfo]  seqindex:0 count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *resultData = dataDic[@"data"];
        
        
        if ([[dataDic objectForKey:@"type"] integerValue]) {
            NSArray *array = resultData;
            for (NSDictionary *dict in array) {
                
                JZPublishHistoryData *listModel = [JZPublishHistoryData yy_modelWithDictionary:dict];
                
                [self.listDataArray addObject:listModel];
            }
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    }];
    
    
}
-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}





@end
