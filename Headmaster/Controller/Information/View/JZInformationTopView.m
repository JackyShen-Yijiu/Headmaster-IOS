//
//  JZInformationTopView.m
//  Headmaster
//
//  Created by 雷凯 on 16/5/6.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZInformationTopView.h"
#import "JZInformationData.h"
#import <YYModel.h>

@interface JZInformationTopView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *pictureArray;//存放图片名称的数组
@property (nonatomic, assign) NSInteger index;//记录数组的下标
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation JZInformationTopView
//初始化

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadData];
      
    }
    return self;

}

//懒加载
-(NSMutableArray *)pictureArray{
    if (!_pictureArray) {
        _pictureArray = [[NSMutableArray alloc]init];
    }
    return _pictureArray;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;//隐藏滚动条
        _scrollView.pagingEnabled = YES;//设置分页
        _scrollView.contentSize = CGSizeMake(kJZWidth * 3, 0);//设置可滑尺寸
        _scrollView.contentOffset = CGPointMake(kJZWidth, 0);//设置初始偏移量
    }
    return _scrollView;
}
-(UIPageControl *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(kJZWidth - 100, 100, 100, 50)];
        _pageController.numberOfPages = self.pictureArray.count;//圆点个数
        _pageController.currentPage = 0;//初始选中第一个圆点
        _pageController.pageIndicatorTintColor = [UIColor whiteColor];//圆点颜色
        _pageController.currentPageIndicatorTintColor = [UIColor greenColor];//当前圆点颜色
        _pageController.enabled = NO;//由于后面要添加计时器,所以此处取消圆点选中事件
        
    }
    return _pageController;
}
//往sctollView上添加imgView:初始时让第二个imgView显示第一张图片(三图轮播,因此只创建三个imgView即可,始终让中间的imgView显示当前图片)
- (void)addImgViewToScrollView{
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kJZWidth * i, 0, kJZWidth, 160)];
        imgView.tag = 1000 + i;//添加标记,方便后面找到
        if (i == 0) {
//            imgView.image = [UIImage imageNamed:self.pictureArray.lastObject];
            [imgView sd_setImageWithURL:[NSURL URLWithString:self.pictureArray.lastObject]];
            
        }
        if (i == 1) {
//            imgView.image = [UIImage imageNamed:self.pictureArray.firstObject];
            [imgView sd_setImageWithURL:[NSURL URLWithString:self.pictureArray.firstObject]];

        }
        if (i == 2) {
//            imgView.image = [UIImage imageNamed:self.pictureArray[1]];
            [imgView sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[1]]];

        }
        imgView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:imgView];
    }
}
//scrollView结束减速时执行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= kJZWidth) {
        //根据偏移量是向左还是右分别控制index的值
        if (self.index == self.pictureArray.count - 1) {
            self.index = 0;
        }else{
            self.index ++;
        }
    }else{
        if (self.index == 0) {
            self.index = self.pictureArray.count -1;
        }else{
            self.index --;
        }
    }
    //调整好index的值之后重新设置下偏移量以及当前选中的圆点
    [self.scrollView setContentOffset:CGPointMake(kJZWidth, 0) animated:NO];
    self.pageController.currentPage = self.index;
    //让中间的imgView始终显示index位置的图片(中心思想)
    [self addImage:self.index];
}

// 改变imageView显示的图片名称
- (void)addImage:(NSInteger)index{
    //找到添加到scrollView上的imgView
    UIImageView *imageView1 = (UIImageView *)[self.scrollView viewWithTag:1000];
    UIImageView *imageView2 = (UIImageView *)[self.scrollView viewWithTag:1001];
    UIImageView *imageView3 = (UIImageView *)[self.scrollView viewWithTag:1002];
    if (index == self.pictureArray.count - 1){
    
        
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[index]]];
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[index-1]]];
        [imageView3 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[0]]];

    }
    else if (index == 0){

        
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray.lastObject]];
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[index]]];
        [imageView3 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[index+1]]];
    }
    else{
        
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[index-1]]];
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[index]]];
        [imageView3 sd_setImageWithURL:[NSURL URLWithString:self.pictureArray[index+1]]];

    }
    
}
//创建计时器
- (void)initTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(loadScrollViewImage) userInfo:nil repeats:YES];
}
//计时器要执行的方法:每次执行改变偏移量
- (void)loadScrollViewImage{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + kJZWidth, 0) animated:YES] ;
}

//偏移量改变并且有滚动动画才会执行该方法,内部代码与上面结束减速(scrollViewDidEndDecelerating:)要执行的代码相同
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //NSLog(@"11111");
    if (scrollView.contentOffset.x >= kJZWidth) {
        //根据偏移量是向左还是右分别控制index的值
        if (self.index == self.pictureArray.count - 1) {
            self.index = 0;
        }else{
            self.index ++;
        }
    }else{
        if (self.index == 0) {
            self.index = self.pictureArray.count -1;
        }else{
            self.index --;
        }
    }
    //调整好index的值之后重新设置下偏移量以及当前选中的圆点
    [self.scrollView setContentOffset:CGPointMake(kJZWidth, 0) animated:NO];
    self.pageController.currentPage = self.index;
    //让中间的imgView始终显示index位置的图片(中心思想)
    [self addImage:self.index];
}

//防止计时器与拖动手势冲突
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate] ;
    self.timer = nil ;
}
//拖拽结束时开启一个新的计时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self initTimer] ;
}

-(void)loadData {
    
    [NetworkEntity informationListWithseqindex:0 count:3 success:^(id responseObject) {
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        
        if (type) {
            
            NSArray *data = [responseObject objectForKey:@"data"];
            
            if (data) {
                
                
                for (NSDictionary  *dict in data) {
                    JZInformationData *listModel = [JZInformationData yy_modelWithJSON:dict];
                    
                    
                    [self.pictureArray addObject:listModel.logimg];
                    
                }
                
                self.index = 0;
                [self addSubview:self.scrollView];
                [self addImgViewToScrollView];
                
                [self initTimer];
                
            }else {
                ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"暂无数据"];
                [alertView show];
                
            }
            
            
        }else {
            
            ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
            [alertView show];
        }
        
        
        
        
    } failure:^(NSError *failure) {
        ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络出错啦"];
        [alertView show];
        
    }];
    
    
}


@end
