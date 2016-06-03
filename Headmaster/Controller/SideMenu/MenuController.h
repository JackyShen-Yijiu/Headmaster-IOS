//
//  MenuController.h
//  Headmaster
//
//  Created by 胡东苑 on 15/12/7.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseTableController.h"

@protocol WMMenuViewControllerDelegate <NSObject>

@optional

- (void)didSelectItem:(NSString *)title indexPath:(NSIndexPath *)indexPath; // 点击tableView的cell

@end

@interface MenuController : YBBaseTableController

@property (weak, nonatomic) id<WMMenuViewControllerDelegate> delegate;

+ (UIImageView *)defaultImageView;

@end
