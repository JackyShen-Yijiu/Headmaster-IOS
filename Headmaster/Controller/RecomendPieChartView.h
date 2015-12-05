//
//  RecomendPieChartView.h
//  Headmaster
//
//  Created by kequ on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecomendPieChartView : UIView
@property(nonatomic,assign)BOOL isExpand;
- (void)updateUIWithCountInfo:(NSDictionary *)countInfo;
@end
