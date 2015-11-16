//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "FindFirstViewController.h"
#import "AllTableViewController.h"


@interface FindFirstViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property(nonatomic, strong)NSArray * titleArray;//存放标题数组

@end

@implementation FindFirstViewController



- (void)viewDidLoad {
    
    self.dataSource = self;
    self.delegate = self;
    
    self.title = @"电影网";
    self.titleArray = @[@"新闻",@"预告片",@"排行榜",@"影评"];
    self.viewsCount = @[@"news",@"trailer",@"topList",@"review"];
    
    // Keeps tab bar below navigation bar on iOS 7.0+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
 
    [[ShareAnimationLoad ShareAnimation]animationingLoad:self.view];

   
    [super viewDidLoad];
}

#pragma mark - ViewPagerDataSource
//标题个数
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.titleArray.count;
}
//展示标题
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = [NSString stringWithFormat:@"%@", self.titleArray[index]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}
//展示详情页面的方法
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    AllTableViewController *cvc = [[UIStoryboard storyboardWithName:@"Find" bundle:nil] instantiateViewControllerWithIdentifier:@"ALLVC"];
    
    cvc.viewName = [NSString stringWithFormat:@"%@", self.viewsCount[index]];
   
    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
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
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    return color;
}

@end
