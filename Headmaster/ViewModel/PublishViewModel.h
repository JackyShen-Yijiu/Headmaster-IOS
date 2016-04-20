//
//  PublishViewModel.h
//  Headmaster
//
//  Created by 胡东苑 on 15/12/4.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface PublishViewModel : YBBaseViewModel

@property (nonatomic, strong) NSMutableArray *publishData;

@property (nonatomic, copy) void (^refreshBlock)(void);

//- (void)needPublishMessageWithContentStr:(NSString *)str WithType:(NSString *)type;

@end
