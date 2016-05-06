//
//  JZComplaintDetailView.h
//  Headmaster
//
//  Created by 雷凯 on 16/5/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZComplaintDetailView : UIView

///  顶部View
@property (nonatomic, weak) UIView *topView;
///  学员头像
@property (nonatomic, weak) UIImageView *studentIcon;
///  学员姓名
@property (nonatomic, weak) UILabel *studentNameLabel;
///  投诉的对象头像
@property (nonatomic, weak) UIImageView *complainIcon;
//// 投诉的名称
@property (weak, nonatomic)  UILabel *complaintNameLabel;
///  投诉的小图标
@property (nonatomic, weak) UIImageView *talkComplaintImageView;
///  箭头图片
@property (nonatomic, weak) UIImageView *directionImageView;

///  底部View
@property (nonatomic, weak) UIView *bottomView;
///"投诉内容"这四个文字
@property (nonatomic, weak) UILabel *complaintContent;
/// 投诉的时间
@property (weak, nonatomic)  UILabel *complaintTime;

/// 投诉详情
@property (weak, nonatomic)  UILabel *complaintDetail;
/// 投诉的第一张图片
@property (weak, nonatomic)  UIImageView *complaintFirstImg;
/// 投诉的第二张图片
@property (weak, nonatomic)  UIImageView *complaintSecondImg;
/// 放置两张图片的View
@property (nonatomic,weak) UIView *complaintImageView;
@end
