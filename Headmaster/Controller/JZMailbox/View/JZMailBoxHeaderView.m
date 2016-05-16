//
//  JZMailBoxHeaderView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/10.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMailBoxHeaderView.h"


@interface JZMailBoxHeaderView ()
///  驾校公告标题
@property (nonatomic, strong) UIImageView *publishImg;
///  “驾校公告”这四个字的label
@property (nonatomic, strong) UILabel *publishLabel;
///  小箭头
@property (nonatomic, strong) UIImageView *extendImg;

//@property (nonatomic, strong) UILabel *badgeLabel;

@end
@implementation JZMailBoxHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];

        
            }
    return self;
}

//- (void)setBadge:(NSInteger)badge
//{
//    NSLog(@"badgeLabel = %@ self.badgeLabel:%@",self.badgeLabel.text,self.badgeLabel);
//    
//    self.badgeLabel.text = [NSString stringWithFormat:@"%zd",badge];
//    self.badgeLabel.layer.masksToBounds = YES;
//    self.badgeLabel.layer.cornerRadius = [self.badgeLabel.text sizeWithFont:self.badgeLabel.font].width/2;
//
//}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.publishImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY) ;
        
        if (YBIphone6Plus) {
            
            make.width.equalTo(@27.6);
            make.height.equalTo(@(27.6));
        }else {
            
            make.width.equalTo(@24);
            make.height.equalTo(@24);
        }
        
        
        
    }];
    
    [self.publishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.publishImg.mas_right).offset(16);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    [self.extendImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    //        [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //            make.centerY.equalTo(self.publishImg.mas_centerY);
    //            make.right.equalTo(self.extendImg.mas_right).offset(-16);
    //
    //        }];
    

}

#pragma mark - 懒加载

-(UIImageView *)publishImg {
    if (!_publishImg) {
        _publishImg = [[UIImageView alloc]init];
        _publishImg.image = [UIImage imageNamed:@"announcement"];
        _publishImg.backgroundColor = [UIColor orangeColor];
        if (YBIphone6Plus) {
            
            _publishImg.layer.cornerRadius = 12*YBRatio;

        }else {
            _publishImg.layer.cornerRadius = 12;

        }
        
        _publishImg.layer.masksToBounds = YES;
        [self addSubview:_publishImg];
    }
    return _publishImg;
}
-(UILabel *)publishLabel {
    if (!_publishLabel) {
        _publishLabel = [[UILabel alloc]init];
        _publishLabel.text = @"驾校公告";
        _publishLabel.textColor = kJZDarkTextColor;
        if (YBIphone6Plus) {
            
            [_publishLabel setFont:[UIFont systemFontOfSize:14*YBRatio]];
            
        }else {
            [_publishLabel setFont:[UIFont systemFontOfSize:14]];

        }
        
        [self addSubview:_publishLabel];
    }
    return _publishLabel;
}
-(UIImageView *)extendImg {
    if (!_extendImg) {
        _extendImg = [[UIImageView alloc]init];
        _extendImg.image = [UIImage imageNamed:@"extend"];
        [self addSubview:_extendImg];
    }
    return _extendImg;
}
//-(UILabel *)badgeLabel {
//    
//    if (!_badgeLabel) {
//        _badgeLabel = [[UILabel alloc]init];
//        _badgeLabel.backgroundColor = kJZRedColor;
//        _badgeLabel.textColor = [UIColor whiteColor];
//        _badgeLabel.font = [UIFont systemFontOfSize:10];
//        [self addSubview:_badgeLabel];
//    }
//    return _badgeLabel;
//    
//}



@end
