//
//  JZComplaintDetailView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZComplaintDetailView.h"
#import "JZComplaintComplaintlist.h"

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
        [self.complaintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(16);
            make.top.mas_equalTo(self.complaintDetail.mas_bottom).offset(12);
            
            if (YBIphone6Plus) {
                make.width.mas_equalTo(158*YBRatio);
                make.height.mas_equalTo(73*YBRatio);
                
            }else {
                make.width.mas_equalTo(158);
                make.height.mas_equalTo(73);
            }
            
            
        }];
        
            [self.complaintFirstImg mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(@0);
                make.left.equalTo(@0);
                make.bottom.equalTo(@0);
                if (YBIphone6Plus) {
                    make.width.mas_equalTo(73*YBRatio);
 
                    
                }else {
                    make.width.mas_equalTo(73);

                }
            }];
        
            [self.complaintSecondImg mas_makeConstraints:^(MASConstraintMaker *make){
                make.top.equalTo(@0);
                make.left.equalTo(self.complaintFirstImg.mas_right).offset(10);
                make.bottom.equalTo(@0);
                if (YBIphone6Plus) {
                    make.width.mas_equalTo(73*YBRatio);
                    
                    
                }else {
                    make.width.mas_equalTo(73);
                    
                }
            }];
        
    }
    
    return self;
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
        
        if (YBIphone6Plus) {
            
            [complaintTime setFont:[UIFont systemFontOfSize:14*YBRatio]];
  
        }else {
            [complaintTime setFont:[UIFont systemFontOfSize:14]];

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
        
        if (YBIphone6Plus) {
            
            [complaintDetail setFont:[UIFont systemFontOfSize:14*YBRatio]];

        }else {
            [complaintDetail setFont:[UIFont systemFontOfSize:14]];

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
        
//        complaintImageView.backgroundColor = [UIColor cyanColor];
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

    self.complaintTime.text = [self getYearLocalDateFormateUTCDate:_data.complaintDateTime];

    
    self.complaintDetail.text = _data.complaintcontent;
    if (_data.piclistr && _data.piclistr.count!=0 && ![_data.piclistr containsObject:str]) {
        
        self.complaintImageView.hidden = NO;
        
        if ((_data.piclistr[0] && [_data.piclistr[0] length]!=0)) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = YES;
            [self.complaintFirstImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[0]]];
        }
        
        if (_data.piclistr.count>1 && _data.piclistr[1] && [_data.piclistr[1] length]!=0) {
            self.complaintFirstImg.hidden = NO;
            self.complaintSecondImg.hidden = NO;
            [self.complaintSecondImg sd_setImageWithURL:[NSURL URLWithString:_data.piclistr[1]]];
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
        
//        NSLog(@"===========complaintDetail%@", detailView.complaintDetail);
//        NSLog(@"detailView.complaintContent.height:%f",detailView.complaintContent.height);
//        NSLog(@"detailView.complaintDetail.height:%f",detailView.complaintDetail.height);
//        NSLog(@"detailView.complaintImageView.height:%f",detailView.complaintImageView.height);

        return detailView.complaintContent.height + detailView.complaintDetail.height + detailView.complaintImageView.height + 56;
    }
    return detailView.complaintContent.height + detailView.complaintDetail.height + 44;
    
}

- (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}



@end
