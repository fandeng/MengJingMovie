//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "HostViewController.h"

#import "GlobelTicketTableViewController.h"


@interface HostViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic, strong) NSArray *titlesArray;//滚动标题
@property (nonatomic, strong) NSArray *columnIdArray;//存放网址Offset的数组

@end

@implementation HostViewController

- (void)viewDidLoad {
    
    self.dataSource = self;
    self.delegate = self;
    
    self.navigationItem.title = @"全球票房榜";
    self.titlesArray = @[@"北 美",@"内 地",@"香 港",@"台 湾",@"日 本",@"韩 国"];
    self.columnIdArray = @[@"2015", @"2020", @"2016", @"2019", @"2017", @"2018"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Keeps tab bar below navigation bar on iOS 7.0+
  
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self TabBarController];
    [[ShareAnimationLoad ShareAnimation]animationingLoad:self.view];
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回
- (void)TabBarController {
    
    UIBarButtonItem * LeftBI = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(click:)];
    self.navigationItem.leftBarButtonItem = LeftBI;
}
//返回上一级
- (void)click:(UIBarButtonItem *)BI {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ViewPagerDataSource

//滚动标题的个数
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.titlesArray.count;
}
//实现滚动标题的方法
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = [NSString stringWithFormat:@"%@", self.titlesArray[index]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}
//展示所有标题视图内容的方法
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    GlobelTicketTableViewController *cvc = [[GlobelTicketTableViewController alloc]init];
    
    cvc.columnId = self.columnIdArray[index];
    
    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;//默认选中第几个视图
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:1.0];
            break;
        default:
            break;
    }
    
    return color;
}

@end
