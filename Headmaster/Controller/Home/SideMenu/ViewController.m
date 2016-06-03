//
//  ViewController.m
//  Headmaster
//
//  Created by ytzhang on 16/5/23.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "ViewController.h"
#import "WMCommon.h"
#import "MenuController.h"
#import "DVVTabBarController.h"
#import "TeacherController.h"
#import "SettingController.h"
#import "JZComplaintListController.h"
#import "HomeController.h"
#import "JZInformationController.h"
#import "JZMailBoxController.h"

@interface ViewController ()<WMMenuViewControllerDelegate>

@property (assign, nonatomic) state   sta;              // 状态(Home or Menu)
@property (assign, nonatomic) CGFloat distance;         // 距离左边的边距
@property (assign, nonatomic) CGFloat leftDistance;
@property (assign, nonatomic) CGFloat menuCenterXStart; // menu起始中点的X
@property (assign, nonatomic) CGFloat menuCenterXEnd;   // menu缩放结束中点的X
@property (assign, nonatomic) CGFloat panStartX;        // 拖动开始的x值

@property (strong, nonatomic) WMCommon               *common;

@property (nonatomic, strong) MenuController *menuVC;

@property (nonatomic, strong) DVVTabBarController *tabBarController;

@property (strong, nonatomic) UIView                 *cover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMenu) name:@"SELFBACK" object:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    self.common = [WMCommon getInstance];
    self.common.homeState = kStateHome;
    self.distance = 0;
    self.menuCenterXStart = self.common.screenW * menuStartNarrowRatio / 2.0;
    self.menuCenterXEnd = self.view.center.x;
    NSLog(@"self.common.screenW= %f",self.common.screenW);
    self.leftDistance = self.common.screenW * viewSlideHorizonRatio;
    
    // 设置背景
    UIImageView *mightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 198)];
    mightView.image = [UIImage imageNamed:@"background_mine"];
    [self.view addSubview:mightView];

    // 设置menu的view
    self.menuVC = [[MenuController alloc] init];
    self.menuVC.delegate = self;
    
    self.menuVC.tableView.frame = [[UIScreen mainScreen] bounds];
    self.menuVC.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuStartNarrowRatio, menuStartNarrowRatio);
    self.menuVC.tableView.center = CGPointMake(self.menuCenterXStart, self.menuVC.view.center.y);
    [self.view addSubview:self.menuVC.view];
    
    // 初始化子控制器
    self.tabBarController = [self homeTabBarView];
    [self.view addSubview:self.tabBarController.view];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.tabBarController.view addGestureRecognizer:pan];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (DVVTabBarController *)homeTabBarView {
    
    NSArray *controllerArray = @[ @"HomeController",
                                  @"JZInformationController",
                                  @"JZMailBoxController"];
    
    NSArray *titleArray = @[ @"数据概览", @"资讯", @"信箱" ];
    
    DVVTabBarController *tabBarVC = [DVVTabBarController new];
    
    // 循环创建Controller
    for (NSInteger i = 0; i < controllerArray.count; i++) {
        
        Class vcClass = NSClassFromString(controllerArray[i]);
        UIViewController *viewController = [vcClass new];
        HMNagationController *naviVC = [[HMNagationController alloc] initWithRootViewController:viewController];
        viewController.title = titleArray[i];
        
        if (0 == i) {
            HomeController *homeVC = (HomeController *)viewController;
            tabBarVC.homeVC = homeVC;
        }
        if (1 == i) {
            JZInformationController *informationVC = (JZInformationController *)viewController;
            tabBarVC.informationVC = informationVC;
        }
        if (2 == i) {
            JZMailBoxController *mailVC = (JZMailBoxController *)viewController;
            tabBarVC.mailBoxVC = mailVC;
        }
        [tabBarVC addChildViewController:naviVC];
        
    }
    
    return tabBarVC;
}

/**
 *  处理拖动事件
 *
 *  @param recognizer
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (self.tabBarController.tabBar.hidden) return;
    
    NSLog(@"self.tabBarController.tabBar.hidden:%d",self.tabBarController.tabBar.hidden);
    
    // 当滑动水平X大于75时禁止滑动
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.panStartX = [recognizer locationInView:self.view].x;
    }
    if (self.common.homeState == kStateHome && self.panStartX >= 75) {
        return;
    }
    
    CGFloat x = [recognizer translationInView:self.view].x;
    NSLog(@"处理拖动事件x:%f",x);
    NSLog(@"self.common.homeState:%d",self.common.homeState);
    
    // 禁止在主界面的时候向左滑动
    //    if (self.common.homeState == kStateHome && x < 0) {
    //        return;
    //    }
    
    CGFloat dis = self.distance + x;
    NSLog(@"处理拖动事件dis:%f",dis);
    
    // 当手势停止时执行操作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"当手势停止时执行操作");
        if (dis >= self.common.screenW * viewSlideHorizonRatio / 2.0) {
            [self showMenu];
        } else {
            [self showHome];
        }
        return;
    }
    
    CGFloat proportion = (viewHeightNarrowRatio - 1) * dis / self.leftDistance + 1;
    NSLog(@"处理拖动事件proportion:%f",proportion);
    
    if (proportion < viewHeightNarrowRatio || proportion > 1) {
        return;
    }
    self.tabBarController.view.center = CGPointMake(self.view.center.x + dis, self.view.center.y);
    self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    CGFloat menuProportion = dis * (1 - menuStartNarrowRatio) / self.leftDistance + menuStartNarrowRatio;
    CGFloat menuCenterMove = dis * (self.menuCenterXEnd - self.menuCenterXStart) / self.leftDistance;
    self.menuVC.tableView.center = CGPointMake(self.menuCenterXStart + menuCenterMove, self.view.center.y);
    self.menuVC.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
    
}
- (void)hiddenSlide
{
    // 退出侧边栏
    if ([WMCommon getInstance].homeState==kStateMenu) {
        [self leftBtnClicked];
    }
}

/**
 *  展示侧边栏
 */
- (void)showMenu {
    
    NSLog(@"self.leftDistance = %f",self.leftDistance);
    self.distance = self.leftDistance;
    self.common.homeState = kStateMenu;
    [self doSlide:viewHeightNarrowRatio];
    [self.tabBarController.view addSubview:self.cover];
    
}

/**
 *  展示主界面
 */
- (void)showHome {
    
    self.distance = 0;
    self.common.homeState = kStateHome;
    [self doSlide:1];
    [UIView animateWithDuration:1.0 animations:^{
        [self.cover removeFromSuperview];
    }];
    
}
/**
 *  实施自动滑动
 *
 *  @param proportion 滑动比例
 */
- (void)doSlide:(CGFloat)proportion {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        NSLog(@"self.distance = %f",self.distance);
        
        
        self.tabBarController.view.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        
        //        self.baomingVC.leftBtn.alpha = self.cover.alpha = (proportion == 1 ? 0.3 : 0);
        
        CGFloat menuCenterX;
        CGFloat menuProportion;
        if (proportion == 1) {
            menuCenterX = self.menuCenterXStart;
            menuProportion = menuStartNarrowRatio;
        } else {
            menuCenterX = self.menuCenterXEnd;
            menuProportion = 1;
        }
        self.menuVC.tableView.center = CGPointMake(menuCenterX, self.view.center.y);
        self.menuVC.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, menuProportion, menuProportion);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)leftBtnClicked {
    
    switch (self.common.homeState) {
        case kStateHome:
            
            [self showMenu];
            
            break;
            
        case kStateMenu:
            
            [self showHome];
            
            break;
            
        default:
            break;
    }
    
}

// 从侧边栏推出相应控制器
#pragma mark - WMMenuViewController代理方法
- (void)didSelectItem:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    
        if (0 == indexPath.row) {
            // 教练
            TeacherController *teacherVC = [[TeacherController alloc] init];
            [self controller:teacherVC];
        }else if (1 == indexPath.row) {
            // 投诉
            
            JZComplaintListController *complaintVC = [[JZComplaintListController alloc] init];
            [self controller:complaintVC];
            
        }else if (2 == indexPath.row) {
            // 设置
            SettingController *vc = [[SettingController alloc] init];
            
            [self controller:vc];
        }
   
}

- (void)controller:(UIViewController *)itemVC{
    itemVC.hidesBottomBarWhenPushed = YES;
    [self showHome];
    switch (self.tabBarController.vcType) {
        case kJZHomeViewController:
            
            [self.tabBarController.homeVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kJZInformentViewController:
            [self.tabBarController.informationVC.navigationController pushViewController:itemVC animated:NO];
            break;
        case kJZMailController:
            [self.tabBarController.mailBoxVC.navigationController pushViewController:itemVC animated:NO];
            break;
            
        default:
            break;
    }
    
}
- (void)changeMenu{
    [self showMenu];
}
- (UIView *)cover
{
    if (_cover==nil) {
        _cover = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _cover.backgroundColor = [UIColor clearColor];
        _cover.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSlide)];
        [_cover addGestureRecognizer:tap];
    }
    return _cover;
}

@end
