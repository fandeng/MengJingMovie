//
//  HotMovieTableViewController.m
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import "LHotMovieTableViewController.h"
#import "LHotMovieTableViewCell.h"
#import "LHotModel.h"
#import "DetailViewController.h"

@interface LHotMovieTableViewController ()

@property(nonatomic,strong)NSMutableArray * hotMovieArray; // 存储hotmovie的Model

@end

@implementation LHotMovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LHotMovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotMovieCell"];

    [[ShareAnimationLoad ShareAnimation] animationingLoad:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 调用解析数据的方法
    [self requesetDataWithUrl];
    

}

#pragma mark ----解析数据

- (void)requesetDataWithUrl
{
    NSURL * url = [NSURL URLWithString:kHotUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    __weak LHotMovieTableViewController * weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            // 给数组开辟空间
            weakSelf.hotMovieArray = [NSMutableArray array];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary * dict in dic[@"movies"]) {
                
                LHotModel * hotModel = [[LHotModel alloc] init];
                
                [hotModel setValuesForKeysWithDictionary:dict];
                
                [weakSelf.hotMovieArray addObject:hotModel];
            }
        }
        // 刷新数据
        [weakSelf.tableView reloadData];
        // 加载完成，隐藏动画
        [[ShareAnimationLoad ShareAnimation] animationSuccessLoad];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.hotMovieArray.count;
}

// 设置cell上显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LHotMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotMovieCell" forIndexPath:indexPath];
    LHotModel * hotmodel = self.hotMovieArray[indexPath.row];
    cell.hotmodel = hotmodel;
//    cell.dayLabel.text = [NSString stringWithFormat:@"%ld",hotmodel.rDay];

    return cell;
}

// 点击cell时推出详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHotModel * hotmodel = self.hotMovieArray[indexPath.row];
    
    DetailViewController * DetailVC = [[UIStoryboard storyboardWithName:@"Show" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailMovieVC"];
    
    DetailVC.LHModel = hotmodel;
    DetailVC.panduan = YES;
    
    [self.navigationController pushViewController:DetailVC animated:YES];
}



- (void)asynRequestWithData:(NSData *)data
{
    // 给hotMovieArray数组开辟空间
//    self.hotMovieArray = [NSMutableArray array];
//    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    for (NSDictionary * dict in dic[@"movies"]) {
//        HotModel * hotModel = [[HotModel alloc] init];
//        [hotModel setValuesForKeysWithDictionary:dict];
//        NSLog(@"dic[movies] = %@",dic[@"movies"]);
//        NSLog(@"------%@",hotModel);
//        for (NSDictionary * dicts in dic[@"movies"][@"nearestShowtime"]) {
//            
//            [hotModel setValuesForKeysWithDictionary:dicts];
//            [_hotMovieArray addObject:hotModel];
//            NSLog(@"++++++%@",hotModel);
//            NSLog(@"########%@",dic[@"movies"][@"nearestShowtime"]);
//        }
//    }
}





@end
