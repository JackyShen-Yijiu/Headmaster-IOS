//
//  HomeGuideController.h
//  Headmaster
//
//  Created by 大威 on 15/12/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeGuideController : UIViewController

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, assign) NSUInteger currentImageFlage;

+ (BOOL)isShowGuide;

+ (void)testGuide;

@end
