//
//  JZComplaintDetailView.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZComplaintComplaintlist;

@interface JZComplaintDetailView : UIView
@property (nonatomic, strong) JZComplaintComplaintlist *data;

+ (CGFloat)complaintDetailViewH:(JZComplaintComplaintlist *)date;

@property (nonatomic, strong) UIViewController *vc;

@end
