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
#import "JZComplaintListController.h"

#import "JZPassRateController.h"
#import "JZCommentListController.h"

@interface HomeController () <BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollView;

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
///  投诉数量
@property (nonatomic, assign) NSInteger complaintCount;

@end

@implementation HomeController

- (UIScrollView *)mainScrollView
{
    if (_mainScrollView==nil) {
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        
    }
    return _mainScrollView;
}

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
        if (YBIphone6Plus) {
            _rightLabel.font = [UIFont systemFontOfSize:8*YBRatio];
        }
        _rightLabel.frame = CGRectMake(_rightView.width-10, 0, 10, 10);
        _rightLabel.layer.masksToBounds = YES;
        _rightLabel.layer.cornerRadius = _rightLabel.width/2;
        [_rightView addSubview:_rightLabel];
        
    }
    return _rightView;
}

- (void)rightViewDidClick
{
    JZComplaintListController *complaintVC = [[JZComplaintListController alloc]init];
    
    complaintVC.count = self.complaintCount;
    
    [self.myNavController pushViewController:complaintVC animated:YES];

//    RecommendViewController *recommendVC = [RecommendViewController new];
//    recommendVC.searchType = self.searchType;
//    recommendVC.commentTag = 3;
//    [self.myNavController pushViewController:recommendVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    // 显示下面的导航栏
    self.tabBarController.tabBar.hidden = NO;
    self.myNavigationItem.title = @"数据概览";
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

    NSLog(@"self.view:%@",self.view);
    
    [self loadComplaintData];
    
    if ([HomeGuideController isShowGuide]) {
        [HomeGuideController show];
    }
    
    [self addSideMenuButton];
    
    [self.view addSubview:self.mainScrollView];
    
    [self.mainScrollView addSubview:self.topView];
    
    // 添加button上面一条线
    UIView *lineTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.5)];
    lineTopView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    // 添加button下面一条线
    UIView *lineDownView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.view.bounds.size.width - 20, 0.5)];
    lineDownView.backgroundColor = [UIColor colorWithHexString:@"2a2a2a"];
    
    [self.mainScrollView addSubview:lineTopView];
    [self.mainScrollView addSubview:lineDownView];
    [self.mainScrollView addSubview:lineDownView];
    [self.mainScrollView addSubview:lineTopView];
    
    // 加载地图用于定位,展示天气信息
    [self addMap];

    [self addBackgroundImage];
    
    self.searchType = kDateSearchTypeToday;
    
    [self.mainScrollView addSubview:self.progressView];
    [self.mainScrollView addSubview:self.moreButton];
    [self.mainScrollView addSubview:self.evaluateView];
    
    self.mainScrollView.contentSize = CGSizeMake(self.view.width, CGRectGetMaxY(self.evaluateView.frame)+64+49);
    
    [self.evaluateView itemClick:^(UIButton *button) {
        RecommendViewController *recommendVC = [RecommendViewController new];
        recommendVC.searchType = self.searchType;
        recommendVC.commentTag = button.tag;
        [self.myNavController pushViewController:recommendVC animated:YES];
    }];

    _viewModel = [HomeViewModel new];
    // 刷新数据
    [_viewModel successRefreshBlock:^{
        
        if (_viewModel.searchType == kDateSearchTypeWeek) {
            
            [self.evaluateView refreshData:_viewModel.evaluateArray];
            self.rightLabel.text = _viewModel.evaluateArray[3];
//            [self.progressView refreshData:@[ @(0), @(0), @(1), @(0) ]];
            [self.progressView refreshpassrate:_viewModel.passrate overstockstudent:_viewModel.overstockstudent];

        }else {
            
            [self.topView refreshSubjectData:_viewModel.subjectArray sameDay:_viewModel.applyCount];
//            [self.progressView refreshData:_viewModel.progressArray];
            [self.progressView refreshpassrate:_viewModel.passrate overstockstudent:_viewModel.overstockstudent];
            
            [self.evaluateView refreshData:_viewModel.evaluateArray];
            self.rightLabel.text = _viewModel.evaluateArray[3];
            
        }
        
        if (_viewModel.evaluateArray[3] && [_viewModel.evaluateArray[3] isEqualToString:@"0"]) {
            self.rightLabel.hidden = YES;
        }
        
    }];
    
    _viewModel.searchType = 1;
    [_viewModel networkRequestRefresh];
    [self testVC];
    
}
- (void)testVC{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                JZCommentListController *vc = [JZCommentListController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
    });

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
        if (YBIphone6Plus) {
            self.temperatureLabel.font = [UIFont systemFontOfSize:16*YBRatio];
        }
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
    detailVC.searchType = kDateSearchTypeWeek;
    detailVC.viewModel = _viewModel;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark 侧栏按钮
- (void)addSideMenuButton {

    self.myNavigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalIcon:@"side" highlightedIcon:@"side" target:self action:@selector(openSideMenu)];

}

#pragma mark 打开侧栏
- (void)openSideMenu {
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
    //
}

#pragma mark - lazy load
- (HomeTopView *)topView {
    if (!_topView) {
        _topView = [[HomeTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 105) withIsHomeDetailsVc:NO];
        _topView.backgroundColor = [UIColor blackColor];
    }
    return _topView;
}

- (HomeProgressView *)progressView {
    if (!_progressView) {
        CGFloat height = kJZWidth * 0.86 + 30;
        _progressView = [[HomeProgressView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), self.view.bounds.size.width, height)];
        _progressView.backgroundColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (HomeEvaluateView *)evaluateView {
    if (!_evaluateView) {
        _evaluateView = [[HomeEvaluateView alloc] initWithFrame:CGRectMake(0,
                                                                           CGRectGetMaxY(_progressView.frame),
                                                                           self.view.width,
                                                                           75+50)];
    }
    return _evaluateView;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton new];
        _moreButton.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.topView.height);
//        _moreButton.center = CGPointMake(self.view.bounds.size.width / 2.f, self.view.bounds.size.height / 2.f);
//        [_moreButton.layer setMasksToBounds:YES];
//        [_moreButton.layer setCornerRadius:_moreButton.bounds.size.width / 2];
//        _moreButton.center = CGPointMake(self.view.centerX, self.view.centerY);
//        _moreButton.backgroundColor = [UIColor redColor];
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UILabel *)temperatureLabel
{
    if (!_temperatureLabel) {
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.frame = CGRectMake(0, 0, 50, 30);
        
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

///  加载投诉数量
-(void)loadComplaintData {
    
    
    [NetworkEntity getComplainListWithUserid:[UserInfoModel defaultUserInfo].userID SchoolId:[UserInfoModel defaultUserInfo].schoolId Index:1 Count:10 success:^(id responseObject) {
        
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            NSDictionary *resultData = responseObject[@"data"];
            
            self.complaintCount = [resultData[@"count"] integerValue];
            
            
        }else{
            
            
        }
        
    } failure:^(NSError *failure) {
        
        
    }];
    
    
    
    
}


@end
