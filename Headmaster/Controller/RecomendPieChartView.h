//
//  RecomendPieChartView.h
//  Headmaster
//
//  Created by kequ on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecomendPieChartView : UIView
@property(nonatomic,strong)UIButton * expandButton;

- (void)updateUIWithCountInfo:(NSDictionary *)countInfo;
@end
