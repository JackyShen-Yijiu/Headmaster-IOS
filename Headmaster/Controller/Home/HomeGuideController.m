//
//  HomeGuideController.m
//  Headmaster
//
//  Created by 大威 on 15/12/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeGuideController.h"

#define kHomeGuideIsShow @"kHomeGuideIsShow"

@interface HomeGuideController ()

@end

@implementation HomeGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] setObject:kHomeGuideIsShow forKey:kHomeGuideIsShow];
    
    self.view.backgroundColor = [UIColor orangeColor];
    _currentImageFlage = 0;
    _imagesArray = @[ @"home_guide_1", @"home_guide_2" ];
    
    [self.view addSubview:self.imageView];
    
    if (self.imagesArray.count) {
        self.imageView.image = [UIImage imageNamed:self.imagesArray[0]];
    }
    self.currentImageFlage = 0;
    self.imageView.frame = self.view.bounds;
}

+ (BOOL)isShowGuide {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kHomeGuideIsShow]) {
        NSString *flageString = [[NSUserDefaults standardUserDefaults] objectForKey:kHomeGuideIsShow];
        if ([flageString isEqualToString:kHomeGuideIsShow]) {
            return NO;
        }
        return YES;
    }
    return YES;
}

#pragma mark 显示视图的方法
+ (void)show {
    // 不使用静态修饰，在ARC中可能会提前释放
    static UIWindow *window = nil;
    window = [UIWindow new];
    window.windowLevel = UIWindowLevelAlert;
    window.backgroundColor = [UIColor clearColor];
    window.rootViewController = [self new];
    [window makeKeyAndVisible];
}

+ (void)testGuide {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kHomeGuideIsShow];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor lightGrayColor];
        [self addTouchForImageView:_imageView];
    }
    return _imageView;
}

- (void)addTouchForImageView:(UIImageView *)imageView {
    
    UITapGestureRecognizer *touch = [UITapGestureRecognizer new];
    touch.numberOfTouchesRequired = 1;
    [touch addTarget:self action:@selector(imageClickAction)];
    [imageView addGestureRecognizer:touch];
    imageView.userInteractionEnabled = YES;
}

- (void)imageClickAction {
    
    self.currentImageFlage += 1;
    
    if (self.currentImageFlage == 2) {
        [self closeView];
        return;
    }
    
    self.imageView.image = [UIImage imageNamed:self.imagesArray[self.currentImageFlage]];
}

- (void)closeView {
    [self.view.window resignKeyWindow];
    self.view.window.hidden = YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
