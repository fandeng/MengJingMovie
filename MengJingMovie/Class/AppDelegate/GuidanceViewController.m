//
//  GuidanceViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/31.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "GuidanceViewController.h"

#import "HomepageViewController.h"

#import "AppDelegate.h"

@interface GuidanceViewController ()<UIScrollViewDelegate>

@property(nonatomic, retain)UIScrollView * scrollView;

@property(nonatomic, retain)UIPageControl * pageControl;

@end

@implementation GuidanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGuide];   //加载新用户指导页面
    
    [self createPageControl];
    
    _scrollView.delegate = self;
}

- (void)createPageControl {
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-50, CGRectGetHeight(self.view.frame)-60, 100, 30)];
    _pageControl.backgroundColor = [UIColor clearColor];
    //设置有多少个圆点
    _pageControl.numberOfPages = 4;
    
    //设置未选中圆点的颜色
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //设置以选中点得颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    
    //添加事件
    [_pageControl addTarget:self action:@selector(clickPageControl:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_pageControl];
    
}

- (void)clickPageControl:(UIPageControl *)pageControl {
    
    [_scrollView setContentOffset:CGPointMake(pageControl.currentPage * CGRectGetWidth(_scrollView.frame),0) animated:YES];
    
}

//3 减速结束的时候（此时停止了）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger number =  scrollView.contentOffset.x /CGRectGetWidth(scrollView.frame);
    
    _pageControl.currentPage = number;
    
    
    
    CLog(@"%s", __FUNCTION__);
    
    
}


- (void)initGuide
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame)*4, 0)];
    [_scrollView setPagingEnabled:YES];  //视图整页显示
    [_scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [imageview setImage:[UIImage imageNamed:@"pre1.png"]];
    [_scrollView addSubview:imageview];
    
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [imageview1 setImage:[UIImage imageNamed:@"pre2.png"]];
    [_scrollView addSubview:imageview1];
    
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [imageview2 setImage:[UIImage imageNamed:@"pre3.png"]];
    [_scrollView addSubview:imageview2];
    
    
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*3, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [imageview3 setImage:[UIImage imageNamed:@"pre4.png"]];
    imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
    [_scrollView addSubview:imageview3];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    [button setTitle:nil forState:UIControlStateNormal];
    [button setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-70, CGRectGetHeight(self.view.frame)-120, 140, 30)];
    [button setTitleColor:[UIColor purpleColor] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"pre5.png"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    [imageview3 addSubview:button];
    
    [self.view addSubview:_scrollView];
}

//button的方法
- (void)firstpressed
{
    [UIView animateWithDuration:1.5 animations:^{
        
        _scrollView.alpha=0;//让scrollview 渐变消失
        
    } completion:^(BOOL finished) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"opinionCount"];
        [_scrollView  removeFromSuperview];//将scrollView移除
 
        AppDelegate *appdele = [UIApplication sharedApplication].delegate;
        [appdele RootViewController];
        
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否允许定位" delegate:self cancelButtonTitle:@"不允许" otherButtonTitles:@"允许", nil];
        [alertView show];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    } else if (buttonIndex == 1){
        return;
    }
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
