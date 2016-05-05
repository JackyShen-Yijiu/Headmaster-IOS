//
//  JZComplaintListView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintListView.h"
#import "JZComplaintCell.h"
static NSString *JZComplaintCellID = @"JZComplaintCell";

@interface JZComplaintListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *listDataArray;

@end

@implementation JZComplaintListView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        
        [self loadData];
        
    }
    return self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZComplaintCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZComplaintCellID];
    
    if (!listCell) {
        
        listCell = [[JZComplaintCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZComplaintCellID];
    }
    
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return listCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 0;
    
}

-(void)loadData {
    
    
}

-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}

@end


