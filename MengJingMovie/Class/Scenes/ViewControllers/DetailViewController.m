//
//  DetailViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/28.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "DetailViewController.h"
#import "LImminentModel.h"
#import "LDetailModel.h"
#import "LIMovieDetailView.h"
#import "LIMovieTableViewCell.h"
#import "LHotModel.h"


@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *contentTableView; //展示网友评论的tableView
@property(nonatomic,strong)NSDictionary * dict; // 解析出来的字典
@property(nonatomic,strong)NSMutableArray * DetailArray;
@property(nonatomic,assign)NSInteger pageIndex; // 上拉刷新传得参数
@property(nonatomic,strong)NSString * totalCount; // 用来接收评论数
@property(nonatomic,strong)NSURL * url;

@end

@implementation DetailViewController
// 懒加载
- (NSMutableArray *)DetailArray
{
    if (_DetailArray == nil) {
        _DetailArray = [NSMutableArray array];
    }
    return _DetailArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 注册cell
    [self.contentTableView registerNib:[UINib nibWithNibName:@"LIMovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"LIMovieCell"];
    
    // 设置代理
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
   
    self.pageIndex = 1; // 初始化页数
    
    // 调用解析数据的方法
    [self requestDataWithUrl];
    // 调用创建表头的方法
    [self showMovieDetailView];
    
    // 上拉加载
    self.contentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    
}
// 实现加载
- (void)footerRefresh
{
    _pageIndex ++;
    if (_pageIndex < 10) {
        
        [self requestDataWithUrl];
    }
    // 结束刷新
    [self.contentTableView.footer endRefreshing];
    // 刷新列表
    [self.contentTableView reloadData];
    // 隐藏当前的上拉刷新控件
    self.contentTableView.footer.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


#pragma mark ----- 解析数据
- (void)requestDataWithUrl
{
    if (_panduan == YES) {
       _url  = [NSURL URLWithString:kMovieReviews(_LHModel.movieId, _pageIndex)];
    }else if (_panduan == NO){
        
        _url = [NSURL URLWithString:kMovieReviews(_LIModel.myId,_pageIndex)];
    }
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:_url];
    __weak DetailViewController * weakself = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            NSLog(@"2222");
        }
        weakself.dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        weakself.totalCount = [NSString stringWithFormat:@"%@",_dict[@"totalCount"]] ;
        for (NSDictionary * dic in _dict[@"cts"]) {
            
            LDetailModel * LDModel = [[LDetailModel alloc] init];
            [LDModel setValuesForKeysWithDictionary:dic];
            [weakself.DetailArray addObject:LDModel];
        }
        [weakself.contentTableView reloadData];
    }];
}

#pragma mark ----设置视图的头部显示电影详情介绍

- (void)showMovieDetailView
{
    // 为什么有个firstObject啊？、？？？？
    LIMovieDetailView * IMDetailView = [[NSBundle mainBundle] loadNibNamed:@"LIMovieDetailView" owner:self options:nil].firstObject;
    // 给contentTableView添加表头
    self.contentTableView.tableHeaderView = IMDetailView;
    // 给表头赋值
    if (_panduan == YES) {
        
        [IMDetailView.MovieImgView sd_setImageWithURL:[NSURL URLWithString:_LHModel.img]];
        IMDetailView.titleLabel.text = _LHModel.titleCn;
        IMDetailView.typeLabel.text = _LHModel.type;
        IMDetailView.dateLabel.text = _LHModel.titleEn;
        IMDetailView.peopleLabel.text = [NSString stringWithFormat:@"%ld人想看",_LHModel.wantedCount];
        IMDetailView.directorLabel.text = _LHModel.directorName;
        IMDetailView.actor1Label.text = _LHModel.actorName1;
        IMDetailView.actor2Label.text = _LHModel.actorName2;
        
    }else if(_panduan == NO){
        
    [IMDetailView.MovieImgView sd_setImageWithURL:[NSURL URLWithString:_LIModel.image]];
    IMDetailView.titleLabel.text = _LIModel.title;
    IMDetailView.typeLabel.text = _LIModel.type;
    IMDetailView.dateLabel.text = _LIModel.releaseDate;
    IMDetailView.peopleLabel.text = [NSString stringWithFormat:@"%ld人想看",_LIModel.wantedCount];
    IMDetailView.directorLabel.text = _LIModel.director;
    IMDetailView.actor1Label.text = _LIModel.actor1;
    IMDetailView.actor2Label.text = _LIModel.actor2;
        
    }
}

#pragma mark ------实现tableView协议方法
// 设置多少分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 设置每个分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DetailArray.count;
}

// 自定义区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
// 设置区头显示内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_totalCount == nil) {
        NSString * str = @"网速不给力，请重新加载";
        [self.contentTableView reloadData];
        return str;
    }else{
    return [NSString stringWithFormat:@"网友评论数:(%@)",_totalCount];
    }
}

// 自定义cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width  = self.view.frame.size.width;
    LDetailModel * model = _DetailArray[indexPath.row];
//    CGFloat height = [LIMovieTableViewCell computerHeightWithText:model.ce ];

    CGFloat height = [LIMovieTableViewCell computerHeightWithText:model.ce Width:width];
    return height+66;
}

// 设置cell上显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LIMovieTableViewCell * Cell = [tableView dequeueReusableCellWithIdentifier:@"LIMovieCell" forIndexPath:indexPath];
    LDetailModel * detailModel = _DetailArray[indexPath.row];
    
    Cell.detailModel = detailModel;
    
    return Cell;
}


@end
