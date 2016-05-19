//
//  JZComplaintDetailView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintDetailView.h"
#import "JZComplaintComplaintlist.h"
//#import "MWPhotoBrowser.h"
#import "NSString+LKString.h"
#import "UIView+LKView.h"

@interface JZComplaintDetailView ()
///"投诉内容"这四个文字
@property (nonatomic, weak) UILabel *complaintContent;
/// 投诉的时间
@property (strong, nonatomic)  UILabel *complaintTime;
/// 投诉详情
@property (strong, nonatomic)  UILabel *complaintDetail;
/// 投诉的第一张图片
@property (strong, nonatomic)  UIImageView *complaintFirstImg;
/// 投诉的第二张图片
@property (strong, nonatomic)  UIImageView *complaintSecondImg;
/// 放置两张图片的View
@property (nonatomic,strong) UIView *complaintImageView;

@property (nonatomic, strong) NSMutableArray *photos;

@end
@implementation JZComplaintDetailView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.complaintContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(16);
            make.left.equalTo(self.mas_left).offset(16);
        }];
    
        [self.complaintTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(16);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
        [self.complaintDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.complaintTime.mas_bottom).offset(12);
            make.left.equalTo(self.mas_left).offset(16);
            make.right.equalTo(self.mas_right).offset(-16);
        }];
        
        NSInteger complaintImageViewW = 158;
        NSInteger complaintImageViewH = 73;
        if (YBIphone6Plus) {
            
            complaintImageViewW = 158 * YBRatio;
            complaintImageViewH = 73 * YBRatio;
        }
        
        [self.complaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(16);
            make.top.mas_equalTo(self.complaintDetail.mas_bottom).offset(12);
            make.width.mas_equalTo(complaintImageViewW);
            make.height.mas_equalTo(complaintImageViewH);

        }];
        
            [self.complaintFirstImg mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(@0);
                make.left.equalTo(@0);
                make.bottom.equalTo(@0);
                make.width.mas_equalTo(complaintImageViewH);

            }];
        
            [self.complaintSecondImg mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(@0);
                make.left.equalTo(self.complaintFirstImg.mas_right).offset(10);
                make.bottom.equalTo(@0);
                make.width.mas_equalTo(complaintImageViewH);

            }];
        
        
        self.complaintFirstImg.userInteractionEnabled = YES;
        self.complaintSecondImg.userInteractionEnabled = YES; 
        
        UITapGestureRecognizer *tapFirst = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeFirstBigImg)];
        [self.complaintFirstImg addGestureRecognizer:tapFirst];
        UITapGestureRecognizer *tapSecond = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeSecondBigImg)];
        [self.complaintSecondImg addGestureRecognizer:tapSecond];


        
    }
    
    return self;
}
-(void)seeFirstBigImg {

    JZComplaintComplaintlist *data = self.data;
    NSString *picStr = data.piclistr[0];
    
    [UIView showBigImageStr:picStr];
    
}
-(void)seeSecondBigImg {
    JZComplaintComplaintlist *data = self.data;
    NSString *picStr = data.piclistr[1];
    
    [UIView showBigImageStr:picStr];

}



#pragma mark - 懒加载
-(UILabel *)complaintContent {
    if (!_complaintContent) {
        
        UILabel *complaintContent = [[UILabel alloc]init];
        
        complaintContent.text = @"投诉内容";
        
        if (YBIphone6Plus) {
            [complaintContent setFont:[UIFont systemFontOfSize:14*YBRatio]];

            
        }else {
            [complaintContent setFont:[UIFont systemFontOfSize:14]];

        }
        complaintContent.textColor = kJZLightTextColor;
        
        self.complaintContent = complaintContent;
        
        [self addSubview:complaintContent];
        
    }
    
    return _complaintContent;
}


-(UILabel *)complaintTime {
    if (!_complaintTime) {
        
        UILabel *complaintTime = [[UILabel alloc]init];
        [complaintTime setFont:[UIFont systemFontOfSize:14]];
        if (YBIphone6Plus) {
            [complaintTime setFont:[UIFont systemFontOfSize:14*YBRatio]];
        }
        complaintTime.textColor = kJZLightTextColor;
        
        self.complaintTime = complaintTime;
        
        [self addSubview:complaintTime];
        
    }
    
    return _complaintTime;

}

-(UILabel *)complaintDetail {
    
    if (!_complaintDetail) {
        
        UILabel *complaintDetail = [[UILabel alloc]init];
        [complaintDetail setFont:[UIFont systemFontOfSize:14]];
        if (YBIphone6Plus) {
            [complaintDetail setFont:[UIFont systemFontOfSize:14*YBRatio]];
        }

        complaintDetail.textColor = kJZDarkTextColor;
        
        self.complaintDetail = complaintDetail;
        
        [self addSubview:complaintDetail];
        
    }
    
    return _complaintDetail;
}
-(UIView *)complaintImageView {
    
    if (!_complaintImageView) {
        
        UIView *complaintImageView = [[UIView alloc]init];
        self.complaintImageView = complaintImageView;
        
        [self addSubview:complaintImageView];
        
    }
    return _complaintImageView;
}
-(UIImageView *)complaintFirstImg {
    
    if (!_complaintFirstImg) {
        
        UIImageView *complaintFirstImg = [[UIImageView alloc]init];
        self.complaintFirstImg = complaintFirstImg;
        [self.complaintImageView addSubview:complaintFirstImg];
    }
    return _complaintFirstImg;
    
}

-(UIImageView *)complaintSecondImg {
    if (!_complaintSecondImg) {
        
        UIImageView *complaintSecondImg = [[UIImageView alloc]init];
        self.complaintSecondImg = complaintSecondImg;
        [self.complaintImageView addSubview:complaintSecondImg];
        
    }
    return _complaintSecondImg;
}

-(void)setData:(JZComplaintComplaintlist *)data {
    
    _data = data;
    
    NSString *str = @"""";

    self.complaintTime.text = [NSString getYearLocalDateFormateUTCDate:_data.complaintDateTime style:LKDateStyleDefault];

    
    self.complaintDetail.text = _data.complaintcontent;
    if (_data.piclistr && _data.piclistr.count!=0 && ![_data.piclistr containsObject:str]) {
        
        self.complaintImageView.hidden = NO;
        
        if ((_data.piclistr[0] && [_data.piclistr[0] length]!=0)) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = YES;
            [self.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[0]]placeholderImage:[UIImage imageNamed:@"pic_load"]];
            
        }
        if (_data.piclistr.count>1 && _data.piclistr[1] && [_data.piclistr[1] length]!=0) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = NO;
            [self.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[1]]placeholderImage:[UIImage imageNamed:@"pic_load"]];
        }
        
    }else{
        
        self.complaintImageView.hidden = YES;
        
    }
    
}

+ (CGFloat)complaintDetailViewH:(JZComplaintComplaintlist *)date;
{
    
    NSLog(@"%@",date.complaintcontent);
    JZComplaintDetailView *detailView = [[JZComplaintDetailView alloc]init];
    
    detailView.data = date;
    
    [detailView layoutIfNeeded];
    NSString *str = @"""";

    if (date.piclistr && date.piclistr.count!=0 && ![date.piclistr containsObject:str]) {
        

        return detailView.complaintContent.height + detailView.complaintDetail.height + detailView.complaintImageView.height + 56;
    }
    return detailView.complaintContent.height + detailView.complaintDetail.height + 44;
    
}

@end
