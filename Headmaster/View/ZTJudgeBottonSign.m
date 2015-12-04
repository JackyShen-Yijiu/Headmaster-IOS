//
//  ZTJudgeBottonSign.m
//  SingerDataView
//
//  Created by ytzhang on 15/12/1.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "ZTJudgeBottonSign.h"
# define ksystemH [UIScreen mainScreen].bounds.size.height
# define ksystemW [UIScreen mainScreen].bounds.size.width


@implementation ZTJudgeBottonSign
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBottonView];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)addBottonView
{
    
    NSArray *strArray = @[@"好评",@"中评",@"差评",@"投诉"];
    NSArray *colorArray = @[@"ff00f0",@"00ffcc",@"f3ad54",@"ff663a"];
    CGFloat smallGap = 3.f;
//    CGFloat bigCap = 5.0f;
    CGFloat bigCap = (ksystemW - 4 * 63 - 80) / 3;
    CGFloat bottomW = self.bounds.size.width;
    CGFloat bottonH = self.bounds.size.height;
    CGSize viewSize = CGSizeMake(10, 10);
    CGSize labelSize = CGSizeMake(50, 50);
    /*
     userhead.layer.borderWidth = 1.0;
     userhead.layer.borderColor = [[UIColor whiteColor] CGColor];
     */
    
    for (int i = 0; i < strArray.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(i * (viewSize.width + labelSize.width + smallGap + bigCap), (bottonH - viewSize.height) / 2, viewSize.width, viewSize.height);
        view.backgroundColor = [UIColor colorWithHexString:colorArray[i]];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius  =  viewSize.height / 2;
        
        
        
        UILabel *signLabel = [[UILabel alloc]init];
        signLabel.frame = CGRectMake((i + 1) * (viewSize.width + smallGap) +   i * (bigCap + labelSize.width), (bottonH - labelSize.height) / 2, labelSize.width, labelSize.height);
        signLabel.font = [UIFont systemFontOfSize:12.f];
        signLabel.text = strArray[i];
        signLabel.textColor = [UIColor colorWithHexString:colorArray[i]];
        [self addSubview:view];
        [self addSubview:signLabel];
        
        
        
    }
}
@end
