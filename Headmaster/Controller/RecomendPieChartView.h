//
//  RecomendPieChartView.h
//  Headmaster
//
//  Created by kequ on 15/12/3.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecomendPieChartViewModel : NSObject
@property(nonatomic,assign)NSInteger goodsRemcondCount;
@property(nonatomic,assign)NSInteger mediaRemcondCount;
@property(nonatomic,assign)NSInteger poorRemcondCount;
@end
@interface RecomendPieChartView : UIView
@property(nonatomic,strong)RecomendPieChartViewModel * model;
@property(nonatomic,assign)BOOL isExpand;
@end
