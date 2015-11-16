//
//  MovieViewController.m
//  MovieTime2
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import "LMovieViewController.h"
#import "LCinemaTableViewController.h"

@interface LMovieViewController ()<UIScrollViewDelegate>


@property(nonatomic,strong)LCinemaTableViewController * cinemaTVC;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *scrollLabel;




@end

@implementation LMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置代理
    self.scrollView.delegate = self;
    
    // 设置默认选中的segment
    _segmentControl.selectedSegmentIndex = 0;
    
    // 给segmentControl添加事件
    [self.segmentControl addTarget:self action:@selector(exchangeView:) forControlEvents:UIControlEventValueChanged];
    
}

// 点击热门电影按钮
- (IBAction)didHotAction:(id)sender {
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 0, 0);
    self.scrollLabel.frame = CGRectMake(self.view.frame.size.width * 0, self.scrollLabel.frame.origin.y, self.scrollLabel.frame.size.width, self.scrollLabel.frame.size.height);
}

// 点击即将播放电影按钮
- (IBAction)didImminentAction:(id)sender {
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width * 1, 0);
    self.scrollLabel.frame = CGRectMake((self.view.frame.size.width / 2) * 1, self.scrollLabel.frame.origin.y, self.scrollLabel.frame.size.width, self.scrollLabel.frame.size.height);
    
    
}

//滑动scrollerView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"%lf",scrollView.contentOffset.x);
    self.scrollLabel.frame = CGRectMake( scrollView.contentOffset.x / 2, self.scrollLabel.frame.origin.y, self.scrollLabel.frame.size.width, self.scrollLabel.frame.size.height);
    
}
// 实现segmentControl的点击事件
- (void)exchangeView:(UISegmentedControl *)SC
{
    switch (SC.selectedSegmentIndex) {
        case 0:
        {
            [self.cinemaTVC.tableView removeFromSuperview];
        }
            break;
        case 1:
        {
            self.cinemaTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"cinemaTVC"];
            self.cinemaTVC.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49);
            [self.view addSubview:self.cinemaTVC.tableView];
        }
            break;
            
        default:
            break;
    }
}


@end
