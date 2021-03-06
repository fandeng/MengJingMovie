//
//  FindTopListTableViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright © 2015年 mengjing. All rights reserved.
//

#import "FindTopListTableViewController.h"

#import "FindTopListDetailTableViewCell.h"

#import "FinftopListDetailMovieTableViewCell.h"

@interface FindTopListTableViewController ()

@property(nonatomic, strong)NSString * urlString;

@property(nonatomic, strong)NSMutableArray * headerArray;

@property(nonatomic, strong)NSMutableArray * modelsArray;

@property(nonatomic, assign)NSInteger count;

@property(nonatomic, assign)NSInteger   total;

@end

@implementation FindTopListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Register];
    self.count = 1;
    [self TabBarController];
    
    self.headerArray = [NSMutableArray array];
    self.modelsArray = [NSMutableArray array];
    [self parserURL];
    
    self.title = self.titleN;
    [[ShareAnimationLoad ShareAnimation]animationingLoad:self.view];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

//刷新方法
- (void)loadMoreData {
    
    if ((self.total <= self.modelsArray.count )) {
       
        [self.tableView.footer endRefreshing];
        return;
    }
        self.count += 1;
        [self parserURL];
       [self.tableView.footer endRefreshing];
}

//注册
- (void)Register{
    
    UINib * nib = [UINib nibWithNibName:@"FindTopListDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"findtopListDetailCell_id"];
    
    UINib * nib1 = [UINib nibWithNibName:@"FinftopListDetailMovieTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"findtopListDetailMovieCell_id"];
}

//解析数据
- (void)parserURL {
    
    //self.urlString = [NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetails.api?pageIndex=%ld&topListId=%ld",self.count,self.myID];
    NSURL *url = [NSURL URLWithString:kFindTopListDetail((long)self.count, (long)self.myID)];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            
            [[ShareAnimationLoad ShareAnimation]animationSuccessLoad];
            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * headerDic = dic[@"topList"];
            
            [self.headerArray addObject:headerDic[@"name"]];
            [self.headerArray addObject:headerDic[@"summary"]];
            //NSLog(@"%@",self.type);
            if ([self.type isEqualToString:@"0"]) {
                
                NSArray * array = dic[@"movies"];
                for (NSDictionary * dict in array) {
                    
                    FindModel * model = [FindModel new];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.modelsArray addObject:model];
                    self.total = [dic[@"totalCount"] integerValue];
                    
                }
            }else {
                
                NSArray * array = dic[@"persons"];
                for (NSDictionary * dict in array) {
                    
                    FindModel * model = [FindModel new];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.modelsArray addObject:model];
                    self.total = [dic[@"totalCount"] integerValue];
                }
            }
        }
        [self.tableView reloadData];
    }];
}

//导航栏左侧按钮
- (void)TabBarController {
    
    UIBarButtonItem * LeftBI = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(click:)];
    self.navigationItem.leftBarButtonItem = LeftBI;
}

//返回方法
- (void)click:(UIBarButtonItem *)BI {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelsArray.count;
}

//点击方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.type isEqualToString:@"0"]) {
        
        FinftopListDetailMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"findtopListDetailMovieCell_id" ];
        
        FindModel * model = self.modelsArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell fetchdataWithModel:model];
        return cell;
    }else {
        
        FindTopListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"findtopListDetailCell_id" ];
        
        FindModel * model = self.modelsArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell fetchdataWithModel:model];
        
        return cell;
    }
    
    
    return nil;
}
//cell的高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.type isEqualToString:@"0"]) {
        
        return 200;
    }
    return 140;
}


@end
