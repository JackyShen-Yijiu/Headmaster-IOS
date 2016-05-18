//
//  LKNoDataView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/18.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "LKNoDataView.h"
@implementation LKNoDataView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        self.backgroundColor = JZ_MAIN_BACKGROUND_COLOR;
    }
    
    return self;
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_centerY).offset(-60-28);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(14);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(kJZWidth));
        make.height.equalTo(@14);
        
    }];

}
-(UILabel *)noDataLabel {
    if (!_noDataLabel) {
        
        self.noDataLabel = [[UILabel alloc]init];
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
        self.noDataLabel.font = [UIFont systemFontOfSize:14];
        self.noDataLabel.textColor = kJZLightTextColor;
        [self addSubview:self.noDataLabel];

    }
    
    return _noDataLabel;
}

-(UIImageView *)noDataImageView {
    if (!_noDataImageView) {
        
        self.noDataImageView = [[UIImageView alloc]init];
        
        [self addSubview:self.noDataImageView];
        
    }
    return _noDataImageView;
}

@end
