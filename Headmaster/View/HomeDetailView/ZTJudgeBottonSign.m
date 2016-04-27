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
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews {
    
    [self addBottonView];
}


- (void)addBottonView
{
    
    NSArray *strArray = @[@"好评",@"中评",@"差评",@"投诉"];
    NSArray *colorArray = @[@"00FFCC",@"F3AD54",@"FF663A",@"ED1C24"];
//    CGFloat smallGap = 3.f;
//    CGFloat bigCap = 5.0f;
//    CGFloat bigCap = (ksystemW - 4 * 63 - 80) / 3;
//    CGFloat bottonH = self.bounds.size.height;
    /*
     userhead.layer.borderWidth = 1.0;
     userhead.layer.borderColor = [[UIColor whiteColor] CGColor];
     */
    CGFloat margin = self.bounds.size.width / 4.f;
    for (int i = 0; i < strArray.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 15, 10, 10);
        view.backgroundColor = [UIColor colorWithHexString:colorArray[i]];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius  =  10 / 2;
        
        UILabel *signLabel = [[UILabel alloc]init];
        signLabel.frame = CGRectMake(10, 0, 50, 40);
        signLabel.font = [UIFont systemFontOfSize:12.f];
        if (YBIphone6Plus) {
            signLabel.font = [UIFont systemFontOfSize:12.f*YBRatio];
        }
        signLabel.text = strArray[i];
        signLabel.textColor = [UIColor colorWithHexString:colorArray[i]];
        
        UIView *oneView = [UIView new];
        oneView.frame = CGRectMake(30 + margin * i, 0, 60, 40);
        [oneView addSubview:view];
        [oneView addSubview:signLabel];
        [self addSubview:oneView];
    }
}
@end
