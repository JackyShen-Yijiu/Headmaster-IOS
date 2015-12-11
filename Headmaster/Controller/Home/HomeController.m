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


@interface HomeController () <BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) HomeTopView *topView;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) HomeEvaluateView *evaluateView;

@property (nonatomic, strong) HomeProgressView *progressView;

@property (nonatomic, strong) HomeSeeTimeView *seeTimeView;

@property (nonatomic, strong) HomeViewModel *viewModel;

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic,strong) UILabel *temperatureLabel;

@property (nonatomic,strong) UIImageView *WeatherimageViewWeather;

@property (nonatomic,strong) WeatherViewModel *weatherViewModel;

@property (nonatomic,strong) NSString *temperatureStr;

@property (nonatomic,strong) NSString *weatherUrl;


@end

@implementation HomeController

- (void)viewWillAppear:(BOOL)animated
{
    // 显示下面的导航栏
    self.tabBarController.tabBar.hidden = NO;
    self.myNavigationItem.title = @"数据概述";
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSideMenuButton];
//    [self addWeatherImage];
    self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64 - 49);
    
    [self.view addSubview:self.topView];
    
    // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 0, self.view.bounds.size.width - 15, 2)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(7.5, 62, self.view.bounds.size.width - 15, 2)];
    lineDownView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    
    [self.view addSubview:lineTopView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:lineDownView];
    [self.view addSubview:lineTopView];
    // 加载地图用于定位,展示天气信息
    [self addMap];

    // 加载天气数据
    [self addWeatherData];
    
    
    // Do any additional setup after loading the view.
    [self addBackgroundImage];
    
    self.searchType = kDateSearchTypeToday;
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.moreButton];
    [self.view addSubview:self.evaluateView];
    [self.view addSubview:self.seeTimeView];
    
    [self.evaluateView itemClick:^(UIButton *button) {
        
        RecommendViewController *recommendVC = [RecommendViewController new];
        recommendVC.searchType = self.searchType;
        [self.myNavController pushViewController:recommendVC animated:YES];
    }];
    
    [self.seeTimeView itemClick:^(UIButton *button) {
        
        if (button.tag + 1 == self.searchType) {
            return;
        }
        self.searchType = button.tag + 1;
        if (button.tag == 2) {
            _viewModel.searchType = kDateSearchTypeWeek;
            [_viewModel networkRequestRefresh];
            
        }else {
            if(button.tag == 0) {
                _viewModel.searchType = kDateSearchTypeToday;
            }else if(button.tag == 1 ) {
                _viewModel.searchType = kDateSearchTypeYesterday;
            }
            [_viewModel networkRequestRefresh];
        }
    }];
    
    _viewModel = [HomeViewModel new];
    // 刷新数据
    [_viewModel successRefreshBlock:^{
        
        if (_viewModel.searchType == kDateSearchTypeWeek) {
            [self.progressView refreshData:@[ @(0.7), @(0.3), @(1), @(0.72) ]];
            [self.evaluateView refreshData:_viewModel.evaluateArray];
        }else {
            [self.topView refreshSubjectData:_viewModel.subjectArray sameDay:_viewModel.applyCount];
            [self.progressView refreshData:_viewModel.progressArray];
            [self.evaluateView refreshData:_viewModel.evaluateArray];
        }
    }];
    _viewModel.searchType = 1;
    [_viewModel networkRequestRefresh];
    
    [self.progressView refreshData:@[ @(0.7), @(0.3), @(1), @(0.72) ]];
}

#pragma mark ----- 加载天气数据
- (void)addWeatherData
{
    _weatherViewModel = [[WeatherViewModel alloc] init];
    [_weatherViewModel networkRequestNeedUpRefreshWithCityName:@"北京市"];
    [_weatherViewModel successRefreshBlock:^{
        HomeWeatherModel *homeModel = [_weatherViewModel.weatherArray lastObject];
        
        NSString *str = [NSString stringWithFormat:@"%@℃",homeModel.temperature];
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


        
//        [self.WeatherimageViewWeather downloadImage:homeModel.weather_pic];
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
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(15, 7, 36, 30);
//    btn.backgroundColor = [UIColor redColor];
    [btn setBackgroundImage:[UIImage imageNamed:@"headerIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openSideMenu) forControlEvents:UIControlEventTouchUpInside];
    self.myNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, 37, 80, 31)];
    [view addSubview:self.temperatureLabel];
    [view addSubview:self.WeatherimageViewWeather];
    
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

#pragma mark 打开侧栏
- (void)openSideMenu {
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
    //
}

#pragma mark - lazy load

- (HomeTopView *)topView {
    if (!_topView) {
        _topView = [HomeTopView new];
        _topView.frame = CGRectMake(0, 0, self.view.width, 60);
//        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}

- (HomeProgressView *)progressView {
    if (!_progressView) {
        _progressView = [HomeProgressView new];
        _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width - 100, self.view.bounds.size.width - 100);
        _progressView.center = CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f - 15);
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
        _evaluateView = [HomeEvaluateView new];
//        _evaluateView.backgroundColor = [UIColor redColor];
        _evaluateView.frame = CGRectMake(40,
                                         self.seeTimeView.top - self.seeTimeView.height - 20,
                                         self.view.width - 80,
                                         60);
    }
    return _evaluateView;
}

- (HomeSeeTimeView *)seeTimeView {
    if (!_seeTimeView) {
        CGFloat margin = 52.f;
        if (SCREEN_WIDTH > 320) {
            margin = 60;
        }
        _seeTimeView = [HomeSeeTimeView new];
        _seeTimeView.frame = CGRectMake(margin,
                                        self.view.height - 70,
                                        self.view.width - margin * 2,
                                        50);
    }
    return _seeTimeView;
}
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
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    NSString *str = [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=2T3GAuxuKLNpqrsKT8NjAAgk&callback=renderReverse&location=%f,%f&output=json&pois=1",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
//    NSURL *url = [NSURL URLWithString:str];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    NSArray *keyStr = [responseObject allObjects];
        for (NSString *key  in keyStr) {
            if ([key isEqualToString:@"addressComponent"]) {
                NSDictionary *dic = [responseObject objectForKey:key];
                _cityName = [dic objectForKey:@"city"];
            
            }
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    
}


@end
