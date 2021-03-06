//
//  HomeTopView.h
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTopView : UIView

@property (nonatomic,assign) BOOL isHomeDetailsVc;

//存放全部标题的数组
@property(nonatomic,strong) NSArray *upTitleArray;
@property(nonatomic,strong) NSArray *downTitleArray;

- (void)refreshSubjectData:(NSArray *)array
                   sameDay:(NSString *)sameDay;

- (instancetype)initWithFrame:(CGRect)frame withIsHomeDetailsVc:(BOOL)isHomeDetailsVc;

@end
