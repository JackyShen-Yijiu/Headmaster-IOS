//
//  InformationViewModel.h
//  Headmaster
//
//  Created by 大威 on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface InformationViewModel : YBBaseViewModel

@property (nonatomic, strong) NSMutableArray *informationArray;

@property (nonatomic, copy) void (^tableViewNeedReLoad)(void);

@property (nonatomic, copy) void (^showToast)(void);

- (void)networkRequestNeedUpRefreshWithSeqindex:(NSInteger)seqindex;

@end
