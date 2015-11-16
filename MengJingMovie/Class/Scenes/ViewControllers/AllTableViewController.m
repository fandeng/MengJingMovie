//
//  AllTableViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "AllTableViewController.h"

#import "FindNewsOneTableViewCell.h"

#import <MediaPlayer/MediaPlayer.h>

#import "FindTrailerTableViewCell.h"

#import "FindTopListTableViewCell.h"

#import "FindreviewTableViewCell.h"

#import "FindNewsDetailViewController.h"
#import "CNTicketTableViewController.h"

#import "FindTrailerDetailViewController.h"

#import "FindReviewDetailViewController.h"

#import "FindTopListTableViewController.h"
#import "HostViewController.h"

@interface AllTableViewController ()

@property(nonatomic, strong)NSMutableArray * headerImageArray;//存放头部图片数组

@property(nonatomic, strong)NSMutableArray * modelsUrlArray;//存放解析Cell对象数组

@property(nonatomic, strong)NSMutableArray * modelsImage;//存放cell对象图片

@property(nonatomic, strong)NSMutableArray * typeidArray;//存放typeID

// 视频播放器
@property(nonatomic ,strong)MPMoviePlayerViewController *player;

@property(nonatomic, assign)NSInteger count;//网址偏移量

@property(nonatomic, strong)NSString * urlString;//接收网址


@end

@implementation AllTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.count = 1;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    
    [self parserImage];
    [self Register];
    [self parserUrl];
    
    self.modelsUrlArray = [NSMutableArray array];
    self.typeidArray = [NSMutableArray array];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //NSLog(@"%@",self.viewName);
}

//刷新方法实现
- (void)loadMoreData {
    
    if ([self.viewName isEqualToString:@"news"] || [self.viewName isEqualToString:@"topList"]) {
        
        self.count += 1;
        [self parserUrl];
        [self.tableView.footer endRefreshing];
    }
    [self.tableView.footer endRefreshing];
}

//解析数据
- (void)parserUrl {
    
    if ([self.viewName isEqualToString:@"news"]) {
        self.urlString = kFindNews((long)self.count);
    }else if ([self.viewName isEqualToString:@"trailer"]) {
        self.urlString = kFindTrailer;
    }else if ([self.viewName isEqualToString:@"topList"]) {
        self.urlString = kFindTopList((long)self.count);
    }else {
        self.urlString = kFindReview;
    }

    NSURL * url = [NSURL URLWithString:self.urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    __weak AllTableViewController * weakSelf = self;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            
            [[ShareAnimationLoad ShareAnimation]animationSuccessLoad];

            if ([self.viewName isEqualToString:@"review"]) {
                
                NSMutableArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                for (NSDictionary * dict in array) {
                    
                    FindModel * model = [[FindModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [weakSelf.modelsUrlArray addObject:model];
                }
             
                
            } else {
                
                NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([self.viewName isEqualToString:@"news"]) {
                    
                    NSArray * array = dic[@"newsList"];
                    
                    for (NSDictionary * dict in array) {
                        
                        FindModel * model = [[FindModel alloc]init];
                        [model setValuesForKeysWithDictionary:dict];
                        [weakSelf.typeidArray addObject:dict[@"type"]];
                        [weakSelf.modelsUrlArray addObject:model];
                    }
                }else if ([self.viewName isEqualToString:@"trailer"]) {
                    
                    NSArray * array = dic[@"trailers"];
                    
                    for (NSDictionary * dict in array) {
                        
                        FindModel * model = [[FindModel alloc]init];
                        [model setValuesForKeysWithDictionary:dict];
                        [weakSelf.typeidArray addObject:dict[@"type"]];
                        [weakSelf.modelsUrlArray addObject:model];
                    }
                    
                }else {
                    
                    NSArray * array = dic[@"topLists"];
                    for (NSDictionary * dict in array) {
                        FindModel * model = [[FindModel alloc]init];
                        [model setValuesForKeysWithDictionary:dict];
                        [weakSelf.typeidArray addObject:dict[@"type"]];
                        [weakSelf.modelsUrlArray addObject:model];
                    }
                    
                }
                
            }
        }
        [weakSelf.tableView reloadData];
    }];
}

//注册
- (void)Register {
    
    UINib * nib = [UINib nibWithNibName:@"FindNewsOneTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"findCell_id"];
    
    UINib * nib2 = [UINib nibWithNibName:@"FindTrailerTableViewCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"findTrailerCell_id"];
    
    UINib * nib3 = [UINib nibWithNibName:@"FindTopListTableViewCell" bundle:nil];
    [self.tableView registerNib:nib3 forCellReuseIdentifier:@"findTopListCell_id"];
    
    UINib * nib4 = [UINib nibWithNibName:@"FindreviewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib4 forCellReuseIdentifier:@"findReviewCell_id"];
}

//解析头部图片
- (void)parserImage {
    
    NSURL * url = [NSURL URLWithString:KFindimage];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            self.headerImageArray = [NSMutableArray array];
            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([self.viewName isEqualToString:@"news"]) {
                
                NSMutableDictionary * dict = dic[@"news"];
                [self.headerImageArray addObject:dict[@"title"]];
                [self.headerImageArray addObject:dict[@"imageUrl"]];
            } else if ([self.viewName isEqualToString:@"trailer"]){
                
                NSMutableDictionary * dict = dic[@"trailer"];
                [self.headerImageArray addObject:dict[@"title"]];
                [self.headerImageArray addObject:dict[@"imageUrl"]];
            }else if ([self.viewName isEqualToString:@"topList"]){
                
                NSMutableDictionary * dict = dic[@"topList"];
                [self.headerImageArray addObject:dict[@"title"]];
                [self.headerImageArray addObject:dict[@"imageUrl"]];
                
            }else {
                
                NSMutableDictionary * dict = dic[@"review"];
                [self.headerImageArray addObject:dict[@"title"]];
                [self.headerImageArray addObject:dict[@"imageUrl"]];
            }
        }
        [self.tableView reloadData];
    }];
}
#pragma mark - Table view data source
//多少个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}
//每个区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.modelsUrlArray.count;
}
//创建cell并显示cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.viewName isEqualToString:@"news"]) {
        
            FindNewsOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"findCell_id"];
            FindModel * model = self.modelsUrlArray[indexPath.row];
            [cell fetchdataWithModel:model];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

    } else if ([self.viewName isEqualToString:@"trailer"]){
        
        FindTrailerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"findTrailerCell_id"];
        FindModel * model = self.modelsUrlArray[indexPath.row];
        [cell fetchdataWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }else if ([self.viewName isEqualToString:@"topList"]){
        
        FindTopListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"findTopListCell_id"];
        FindModel * model = self.modelsUrlArray[indexPath.row];
        [cell fetchdataWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else {
        
        FindreviewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"findReviewCell_id"];
        FindModel * model = self.modelsUrlArray[indexPath.row];
        [cell fetchdataWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    return nil;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ((indexPath.section == 0 && [self.viewName isEqualToString:@"topList"])) {
        
        return 110;
    }
    return 140;
}

//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //推出预告片详情页面
    if ([self.viewName isEqualToString:@"trailer"]) {
        //预告片详情
       FindTrailerDetailViewController * findTrailerDetailVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil] instantiateViewControllerWithIdentifier:@"TrailerDetail"];
       FindModel * model = self.modelsUrlArray[indexPath.row];
       findTrailerDetailVC.hightUrl = model.hightUrl;
       findTrailerDetailVC.movieName = model.movieName;
       UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:findTrailerDetailVC];
       [self showViewController:NC sender:Nil];
   
       } else if ([self.viewName isEqualToString:@"review"]) {
        //影评详情
        FindReviewDetailViewController * findReviewDetailVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil] instantiateViewControllerWithIdentifier:@"reviewDetail"];
        FindModel * model = self.modelsUrlArray[indexPath.row];
        findReviewDetailVC.DetailModel = model;
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:findReviewDetailVC];
        [self showViewController:NC sender:nil];
           
    }else if ([self.viewName isEqualToString:@"topList"]) {
        //排行榜详情
        FindTopListTableViewController * findtopListDetailVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil] instantiateViewControllerWithIdentifier:@"topListDetail"];
        FindModel * model = self.modelsUrlArray[indexPath.row];
        findtopListDetailVC.myID = model.myId;
        findtopListDetailVC.type = [NSString stringWithFormat:@"%@", model.type];
        findtopListDetailVC.titleN = model.topListNameCn;
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:findtopListDetailVC];
        [self showViewController:NC sender:nil];
        
    }else {
        //新闻详情
        FindNewsDetailViewController * findNewsDetailVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil]instantiateViewControllerWithIdentifier:@"newsDetail"];
        FindModel * model = self.modelsUrlArray[indexPath.row];
        findNewsDetailVC.model = model;
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:findNewsDetailVC];
        [self showViewController:NC sender:nil];
    }

}

//头部的高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0 && [self.viewName isEqualToString:@"news"]) {
        
        return 250;
    }
    return 190;
}

//头部方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headFoot"];
    if (!header) {
        
        header = [[UITableViewHeaderFooterView  alloc] initWithReuseIdentifier:@"headFoot"];
        
        //头部图片
        UIImageView * imageName = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, CGRectGetWidth(self.view.frame), 190)];
        [imageName sd_setImageWithURL:self.headerImageArray[section+1]];
        
        UILabel * labelName = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 35)];
        labelName.text = self.headerImageArray[section];
        labelName.textColor = [UIColor whiteColor];
        labelName.textAlignment = NSTextAlignmentCenter;
        [imageName addSubview:labelName];
        
        imageName.userInteractionEnabled = YES;
         UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        
        /* step3：把手势识别器加到图片上去 */
        [imageName addGestureRecognizer:singleTap];
        
        
        if ([self.viewName isEqualToString:@"news"]) {
            //头部左侧button
            UIButton * buttonLeft = [UIButton buttonWithType:(UIButtonTypeCustom)];
            buttonLeft.frame = CGRectMake(0, CGRectGetMaxY(imageName.frame),CGRectGetWidth(self.view.frame)/2, 60);
            buttonLeft.backgroundColor = [UIColor redColor];
            [buttonLeft setBackgroundImage:[UIImage imageNamed:@"canvas1"] forState:(UIControlStateNormal)];
            [buttonLeft addTarget:self action:@selector(clickNextPageOne:) forControlEvents:(UIControlEventTouchUpInside)];
            //头部右侧button
            UIButton * buttonRight = [UIButton buttonWithType:(UIButtonTypeCustom)];
            buttonRight.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, CGRectGetMaxY(imageName.frame),CGRectGetWidth(self.view.frame)/2, 60);
            buttonRight.backgroundColor = [UIColor magentaColor];
            [buttonRight setBackgroundImage:[UIImage imageNamed:@"canvas2"] forState:(UIControlStateNormal)];
            [buttonRight addTarget:self action:@selector(clickNextPageTwo:) forControlEvents:(UIControlEventTouchUpInside)];
            [header addSubview:buttonLeft];
            [header addSubview:buttonRight];
        }
        
        [header addSubview:imageName];
        
        return header;
    }
    return nil;
}

/* 识别单击 */
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"==================");
}

//内地票房榜
- (void)clickNextPageOne:(UIButton *)BI {
    
    CNTicketTableViewController * CNTicketVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil]instantiateViewControllerWithIdentifier:@"CNTicket"];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:CNTicketVC];
    [self showViewController:NC sender:nil];
    
}
//全球票房榜
- (void)clickNextPageTwo:(UIButton *)BI {
    
    HostViewController * GlobleTicketVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil]instantiateViewControllerWithIdentifier:@"HostView"];
    UINavigationController * NC = [[UINavigationController alloc]initWithRootViewController:GlobleTicketVC];
    [self showViewController:NC sender:nil];
}



















@end
