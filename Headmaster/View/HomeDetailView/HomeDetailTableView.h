//
//  HomeDetailTableView.h
//  Headmaster
//
//  Created by 大威 on 15/12/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailTableView : UITableView

@property (nonatomic, assign) kDateSearchType searchType;

- (void)setCoachTeacherClickBlock:(void(^)(NSInteger tag))handle;

- (void)setEvaluationClickBlock:(void(^)(NSInteger tag))handle;

@end
