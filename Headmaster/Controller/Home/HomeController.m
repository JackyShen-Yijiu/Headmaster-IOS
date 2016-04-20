//
//  HomeController.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HomeController.h"
#import "HomeTopView.h"
#import "HomeEvaluateView.h"
#import "HomeSeeTimeView.h"
#import "HomeDetailController.h"
#import "HomeViewModel.h"
#import "RESideMenu.h"
#import "CoachOfCoureDetailController.h"
#import "CoachCourseDatailViewModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKGeocodeType.h>

#import "WeatherViewModel.h"
#import "HomeWeatherModel.h"

#import "HomeProgressView.h"
#import "RecommendViewController.h"

#import "HomeGuideController.h"

@interface HomeController () <BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) HomeTopView *topView;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) HomeEvaluateView *evaluateView;

@property (nonatomic, strong) HomeProgressView *progressView;

//@property (nonatomic, strong) HomeSeeTimeView *seeTimeView;

@property (nonatomic, strong) HomeViewModel *viewModel;

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic,strong) UILabel *temperatureLabel;

@property (nonatomic,strong) UIImageView *WeatherimageViewWeather;

@property (nonatomic,strong) WeatherViewModel *weatherViewModel;

@property (nonatomic,strong) NSString *temperatureStr;

@property (nonatomic,strong) NSString *weatherUrl;

@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UILabel *rightLabel;

@end

@implementation HomeController

- (UIView *)rightView
{
    if (_rightView==nil) {
        
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"complaint"]];
        _rightView.frame = CGRectMake(0, 0, 18, 18);
        
        _rightView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightViewDidClick)];
        [_rightView addGestureRecognizer:tap];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"1";
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.backgroundColor = [UIColor redColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont systemFontOfSize:8];
        _rightLabel.frame = CGRectMake(_rightView.width-10, 0, 10, 10);
        _rightLabel.layer.masksToBounds = YES;
        _rightLabel.layer.cornerRadius = _rightLabel.width/2;
        [_rightView addSubview:_rightLabel];
        
    }
    return _rightView;
}

- (void)rightViewDidClick
{
    RecommendViewController *recommendVC = [RecommendViewController new];
    recommendVC.searchType = self.searchType;
    recommendVC.commentTag = 3;
    [self.myNavController pushViewController:recommendVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    // 显示下面的导航栏
    self.tabBarController.tabBar.hidden = NO;
    self.myNavigationItem.title = @"数据概述";
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightView];
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    
    // 加载天气信息
    [self.locService startUserLocationService];
    
    [_viewModel networkRequestRefresh];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
    
    // 停止天气服务
    [self.locService stopUserLocationService];
    
}

- (void)viewDidLoad {

    [super viewDidLoad];

    if ([HomeGuideController isShowGuide]) {
        [HomeGuideController show];
    }
    
    [self addSideMenuButton];

    self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64 - 49);
    
    [self.view addSubview:self.topView];
    
    // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.5)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.view.bounds.size.width - 20, 0.5)];
    lineDownView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    
    [self.view addSubview:lineTopView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:lineTopView];
    
    // 加载地图用于定位,展示天气信息
    [self addMap];

    [self addBackgroundImage];
    
    self.searchType = kDateSearchTypeToday;
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.moreButton];
    [self.view addSubview:self.evaluateView];
//    [self.view addSubview:self.seeTimeView];
    
    [self.evaluateView itemClick:^(UIButton *button) {
        RecommendViewController *recommendVC = [RecommendViewController new];
        recommendVC.searchType = self.searchType;
        recommendVC.commentTag = button.tag;
        [self.myNavController pushViewController:recommendVC animated:YES];
    }];
    
//    [self.seeTimeView itemClick:^(UIButton *button) {
//        
//        if (button.tag + 1 == self.searchType) {
//            return;
//        }
//        self.searchType = button.tag + 1;
//        if (button.tag == 2) {
//            _viewModel.searchType = kDateSearchTypeWeek;
//            [_viewModel networkRequestRefresh];
//            
//        }else {
//            if(button.tag == 0) {
//                _viewModel.searchType = kDateSearchTypeToday;
//            }else if(button.tag == 1 ) {
//                _viewModel.searchType = kDateSearchTypeYesterday;
//            }
//            [_viewModel networkRequestRefresh];
//        }
//    }];
    
    _viewModel = [HomeViewModel new];
    // 刷新数据
    [_viewModel successRefreshBlock:^{
        
        if (_viewModel.searchType == kDateSearchTypeWeek) {
            
            [self.evaluateView refreshData:_viewModel.evaluateArray];
            self.rightLabel.text = _viewModel.evaluateArray[3];
            [self.progressView refreshData:@[ @(0), @(0), @(1), @(0) ]];
            
        }else {
            
            [self.topView refreshSubjectData:_viewModel.subjectArray sameDay:_viewModel.applyCount];
            [self.progressView refreshData:_viewModel.progressArray];
            [self.evaluateView refreshData:_viewModel.evaluateArray];
            self.rightLabel.text = _viewModel.evaluateArray[3];
            
        }
        
        if (_viewModel.evaluateArray[3] && [_viewModel.evaluateArray[3] isEqualToString:@"0"]) {
            self.rightLabel.hidden = YES;
        }
        
    }];
    
    _viewModel.searchType = 1;
    [_viewModel networkRequestRefresh];
    
}

#pragma mark ----- 加载天气数据
- (void)addWeatherData
{
    _weatherViewModel = [[WeatherViewModel alloc] init];
    [_weatherViewModel networkRequestNeedUpRefreshWithCityName:_cityName];
    [_weatherViewModel successRefreshBlock:^{
        HomeWeatherModel *homeModel = [_weatherViewModel.weatherArray lastObject];
        
        if (!homeModel.temperature || !homeModel.temperature.length || [homeModel.temperature isKindOfClass:[NSNull class]]) {
            return ;
        }
        
        NSString *str = [NSString stringWithFormat:@"%@℃",homeModel.temperature];

        NSLog(@"%@", str);
        self.temperatureLabel.text = str;
        self.temperatureLabel.textAlignment = NSTextAlignmentRight ;
        self.temperatureLabel.font = [UIFont systemFontOfSize:16];
        self.temperatureLabel.textColor = [UIColor whiteColor];
        // 显示自定义的天气图片
        if ([homeModel.weather isEqualToString:@"大雪"]) {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"大雪"];
        }
        else if ([homeModel.weather isEqualToString:@"大雨"])
        {
           self.WeatherimageViewWeather.image = [UIImage imageNamed:@"大雨"];
        }
        else if ([homeModel.weather isEqualToString:@"多云"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"多云"];
            
        }
        else if ([homeModel.weather isEqualToString:@"晴"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"晴"];
        }
        else if ([homeModel.weather isEqualToString:@"晴转多云"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"晴转多云"];
        }
        else if ([homeModel.weather isEqualToString:@"小雪"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"小雪"];
        }
        else if ([homeModel.weather isEqualToString:@"小雨"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"小雨"];
        }
        else if ([homeModel.weather isEqualToString:@"雪"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"雪"];
        }
        else if ([homeModel.weather isEqualToString:@"中雨"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"中雨"];
        }
        else if ([homeModel.weather isEqualToString:@"雾"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"雾"];
        }
        else if ([homeModel.weather isEqualToString:@"霾"])
        {
            self.WeatherimageViewWeather.image = [UIImage imageNamed:@"霾"];
        }
    }];
    
}

#pragma mark - action
#pragma mark 更多按钮
- (void)moreButtonAction {
    
    HomeDetailController *detailVC = [HomeDetailController new];
    detailVC.searchType = self.searchType;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark 侧栏按钮
- (void)addSideMenuButton {
    
//    UIButton *btn = [UIButton new];
//    btn.frame = CGRectMake(15, 7, 36, 30);
//    btn.backgroundColor = [UIColor redColor];
//    [btn setBackgroundImage:[UIImage imageNamed:@"side"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    self.myNavigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalIcon:@"side" highlightedIcon:@"side" target:self action:@selector(openSideMenu)];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, 37, 80, 31)];
//    [view addSubview:self.temperatureLabel];
//    [view addSubview:self.WeatherimageViewWeather];
    
//    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

#pragma mark 打开侧栏
- (void)openSideMenu {
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
    //
}

#pragma mark - lazy load

- (HomeTopView *)topView {
    if (!_topView) {
        _topView = [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 105)];
        
    }
    return _topView;
}

- (HomeProgressView *)progressView {
    if (!_progressView) {
        _progressView = [HomeProgressView new];
        _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width - 100, self.view.bounds.size.width - 100);
        _progressView.center = CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f);
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton new];
        _moreButton.frame = CGRectMake(0, 0, self.view.bounds.size.width - 100, self.view.bounds.size.width - 100);
        _moreButton.center = CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f);
        [_moreButton.layer setMasksToBounds:YES];
        [_moreButton.layer setCornerRadius:_moreButton.bounds.size.width / 2];
        _moreButton.center = CGPointMake(self.view.centerX, self.view.centerY);
//        _moreButton.backgroundColor = [UIColor redColor];
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (HomeEvaluateView *)evaluateView {
    if (!_evaluateView) {
        _evaluateView = [[HomeEvaluateView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(_progressView.frame)-20,
                                                                          self.view.width,
                                                                          75+50)];
//        _evaluateView.backgroundColor = [UIColor redColor];
    }
    return _evaluateView;
}

//- (HomeSeeTimeView *)seeTimeView {
//    if (!_seeTimeView) {
//        CGFloat margin = 52.f;
//        if (SCREEN_WIDTH > 320) {
//            margin = 60;
//        }
//        _seeTimeView = [HomeSeeTimeView new];
//        _seeTimeView.frame = CGRectMake(margin,
//                                        self.view.height - 70,
//                                        self.view.width - margin * 2,
//                                        50);
//    }
//    return _seeTimeView;
//}

- (UILabel *)temperatureLabel
{
    if (!_temperatureLabel) {
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.frame = CGRectMake(0, 0, 50, 30);
//        _temperatureLabel.backgroundColor = [UIColor redColor];
        
    }
    return _temperatureLabel;
}

- (UIImageView *)WeatherimageViewWeather
{
    if (!_WeatherimageViewWeather) {
        _WeatherimageViewWeather = [[UIImageView alloc] init];
        _WeatherimageViewWeather.frame = CGRectMake(56, 2, 22, 22);
//        _WeatherimageViewWeather.backgroundColor = [UIColor orangeColor];
    }
    return _WeatherimageViewWeather;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addMap
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];

}

#pragma maek --- 定位的代理方法

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    if (_cityName.length) {
        return;
    }
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    NSString *str = [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=2T3GAuxuKLNpqrsKT8NjAAgk&location=%f,%f&output=json&pois=1",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *result = [responseObject objectInfoForKey:@"result"];
        NSDictionary *addressComponent = [result objectInfoForKey:@"addressComponent"];
        _cityName = [addressComponent objectStringForKey:@"city"];
        [self addWeatherData];
        [self.locService stopUserLocationService];
       
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    }];
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    
}


@end
