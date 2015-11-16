//
//  ViewController.m
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "HomepageViewController.h"
#import "ShareRequestData.h"
#import "CityTableViewController.h"
#import "MoviesModel.h"
#import "MovieShopModel.h"
#import "DJPageView.h"
#import "TodayHotTableViewCell.h"
#import "TodayHotTableViewFooter.h"
#import "FMovieDetailsViewController.h"
#import "RNFrostedSidebar.h"
#import "LMovieViewController.h"
#import "HomeHeaderView.h"
#import "MovieShopTableViewCell.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "FindFirstViewController.h"
#import "ClearCacheHandle.h"
#import "HtmlDetailsViewController.h"
#import "FindNewsDetailViewController.h"


#define kMovieWidth self.moviesScrollView.frame.size.width//电影图片轮播图的宽
#define kMovieHeight self.moviesScrollView.frame.size.height//电影图片轮播图的高

@interface HomepageViewController ()<shareRequestDataDelegate,shareRequestDataDateSource,UITableViewDelegate,UITableViewDataSource,RNFrostedSidebarDelegate,todayHotTableViewFooterDelegate,movieShopTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property(nonatomic, strong)NSMutableArray * allModelArray;//存放电影model
@property(nonatomic, strong)NSMutableDictionary * dic;//存放解析Data的字典
@property(nonatomic, assign)NSInteger cityId;//接收传过来的城市id
@property(nonatomic, strong)UIImageView * movieImgView;//电影图片
@property(nonatomic, strong)HomeHeaderView * headerView;
@property(nonatomic, strong)NSMutableArray * allHotModelArray;//存放热点model
#pragma mark ---每日佳品
@property(nonatomic, strong)MovieShopModel * shopModel;//商城model
@property(nonatomic, strong)TodayHotTableViewFooter * footerView;
@property(nonatomic, strong)NSMutableArray * rotatearray;
@property(nonatomic, strong)NSMutableIndexSet * optionIndeices;//存放索引值
@property(nonatomic, strong)NSMutableArray * rotateArray;

@end

@implementation HomepageViewController
//懒加载
- (NSMutableArray *)allModelArray
{
    if (_allModelArray == nil) {
        
        _allModelArray = [NSMutableArray array];
    }
    return _allModelArray;
}
- (void)viewDidLayoutSubviews
{
    [self addTableHeaderView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    UINib * nib = [UINib nibWithNibName:@"TodayHotTableViewCell" bundle:nil];
    [self.listTableView registerNib:nib forCellReuseIdentifier:@"tableCell"];
    UINib * nib1 = [UINib nibWithNibName:@"MovieShopTableViewCell" bundle:nil];
    [self.listTableView registerNib:nib1 forCellReuseIdentifier:@"movieShopCell"];
    UINib * nib2 = [UINib nibWithNibName:@"FirstTableViewCell" bundle:nil];
    [self.listTableView registerNib:nib2 forCellReuseIdentifier:@"firstCell"];
    UINib * nib3 = [UINib nibWithNibName:@"SecondTableViewCell" bundle:nil];
    [self.listTableView registerNib:nib3 forCellReuseIdentifier:@"secondCell"];
    //加载效果
    [[ShareAnimationLoad ShareAnimation] animationingLoad:self.view];
    //绑定代理
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    //初始化
    _cityId = 290;//默认城市
    self.cityBarButton.title = @"北京🔽";
    [self addFooterView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //通知传值
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(getCityId:) name:@"makeCityId" object:nil];
    
    //创建单例类
    ShareRequestData * handle = [[ShareRequestData alloc] initWithUrlByString:kShopHotUrl];
    //绑定代理
    handle.delegate = self;
}

#pragma mark -----实现通知方法
- (void)getCityId:(NSNotification *)notification
{
    self.cityId = [notification.userInfo[@"cityId"] integerValue];
    self.cityBarButton.title = notification.userInfo[@"cityName"];
    //创建单例类
    ShareRequestData * handleData = [[ShareRequestData alloc] initWithUrlByString:kMoviesUrl((long)_cityId)];
    //绑定代理
    handleData.datesource = self;
}
//城市切换
- (IBAction)cityCutAction:(id)sender {
    
    CityTableViewController * cityVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"city_id"];
    
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:cityVC];
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:NC animated:YES completion:nil];
}
//设置
- (IBAction)setAction:(id)sender {
    
    NSArray * imageArray = @[[UIImage imageNamed:@"profile"],[UIImage imageNamed:@"star"],[UIImage imageNamed:@"movie"],[UIImage imageNamed:@"gear"]];
    
    NSArray * colorArray = @[[UIColor redColor],[UIColor cyanColor], [UIColor greenColor],[UIColor orangeColor]];
    
    RNFrostedSidebar * sideBar = [[RNFrostedSidebar alloc] initWithImages:imageArray selectedIndices:_optionIndeices borderColors:colorArray];
    
    //设置代理
    sideBar.delegate = self;
    
    sideBar.showFromRight = YES;//导航栏从右侧出现 默认是左侧
    
    [sideBar show];
}
#pragma mark ----实现RNFrostedSidebarDelegate协议方法
- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:{
            float data = [[ClearCacheHandle sharedManager] folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
            NSString * titleString = [NSString stringWithFormat:@"为你清理缓存%.2fM", data];
            
            [[ShareRequestData sharedManager] showAlertViewWithMessage:titleString number:1];
            [[ClearCacheHandle sharedManager] clearCache];
            [sidebar dismissAnimated:YES completion:nil];
            break;
        }
        case 1:{
            [[ShareRequestData sharedManager] showAlertViewWithMessage:@"暂时不能收藏;我们会尽快完善" number:1];
            [sidebar dismissAnimated:YES completion:nil];
            break;
        }
        case 2:{
           [[ShareRequestData sharedManager] showAlertViewWithMessage:@"暂时不能反馈;我们会尽快完善" number:1];
            [sidebar dismissAnimated:YES completion:nil];
            break;
        }
        case 3:{
            [[ShareRequestData sharedManager] showAlertViewWithMessage:@"暂时不能反馈;我们会尽快完善" number:1];
            [sidebar dismissAnimated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}
//创建头部
- (void)addTableHeaderView
{
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil] firstObject];
    [self.headerView layoutIfNeeded];
    //绑定代理
    ShareRequestData * defaultHandle = [[ShareRequestData alloc] initWithUrlByString:kMoviesUrl((long)_cityId)];
    defaultHandle.datesource = self;
    
    self.listTableView.tableHeaderView = _headerView;
}
#pragma mark -----创建底部视图
- (void)addFooterView
{
    self.footerView = [[[NSBundle mainBundle] loadNibNamed:@"TodayHotTableViewFooter" owner:nil options:nil] firstObject];
    _footerView.fdelegate = self;
    self.listTableView.tableFooterView = _footerView;
}
#pragma mark ----实现单例shareRequestDataDateSource协议中方法
- (void)shareRequestData:(ShareRequestData *)requestHandle didSucceedWithData:(NSData *)data
{
    [_allModelArray removeAllObjects];
     [_rotateArray removeAllObjects];
    if (data != nil) {
        [[ShareAnimationLoad ShareAnimation] animationSuccessLoad];
        self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.rotateArray = [NSMutableArray array];
        for (NSDictionary * dict in _dic[@"movies"]) {
            
            MoviesModel * model = [MoviesModel new];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.allModelArray addObject:model];
            [_rotateArray addObject:model.img];
        }
        DJPageView *pageView = [[DJPageView alloc] initPageViewFrame:CGRectMake(0, 0, self.headerView.rollView.frame.size.width, 196) webImageStr:_rotateArray didSelectPageViewAction:^(NSInteger index) {
            FMovieDetailsViewController * fMovieDVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"fmovieDetail"];
            
            MoviesModel * model = _allModelArray[index];
            
            fMovieDVC.model = model;
            
            UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:fMovieDVC];
            
            [self presentViewController:NC animated:YES completion:nil];
        }];
        //停留时间
        pageView.duration = 2.0;
        pageView.pageBackgroundColor = [UIColor clearColor];
        pageView.pageIndicatorTintColor = [UIColor clearColor];
        pageView.currentPageColor = [UIColor clearColor];
        [self.headerView.rollView addSubview:pageView];
        [self.listTableView reloadData];
    }
}
#pragma mark ----实现单例shareRequestDataDelegate协议中方法
- (void)shareRequestHandle:(ShareRequestData *)requestHandle data:(NSData *)data
{
    if (data != nil) {
        [[ShareAnimationLoad ShareAnimation] animationSuccessLoad];
        NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.shopModel = [MovieShopModel new];
        
        [_shopModel setValuesForKeysWithDictionary:dic];
        
        self.allHotModelArray = [NSMutableArray array];
        for (NSDictionary * dic in _shopModel.hotPoints) {
            MovieShopModel * model = [MovieShopModel new];
            [model setValuesForKeysWithDictionary:dic];
            
            [_allHotModelArray addObject:model];
        }
        //头部赋值
        _footerView.titleLabel.text = _shopModel.hotMovie[@"title"];
        _footerView.introduceLabel.text = _shopModel.hotMovie[@"movie"][@"desc"];
        [_footerView.filmImgView sd_setImageWithURL:[NSURL URLWithString:_shopModel.hotMovie[@"topCover"]] placeholderImage:nil];
        _footerView.nameLabel.text = _shopModel.hotMovie[@"movie"][@"titleCn"];
        [_footerView.imgView sd_setImageWithURL:[NSURL URLWithString:_shopModel.hotMovie[@"movie"][@"image"]] placeholderImage:nil];
        [self.listTableView reloadData];
    }
}
#pragma mark ----实现tableView协议方法
//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section ==1 || section == 2) {
        return 1;
    }else {
        return 3;
    }
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140;
    }
    if (indexPath.section ==1) {
        return 200;
    } else {
        return 160;
    }
}
//设置cell，显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            MovieShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"movieShopCell" forIndexPath:indexPath];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_shopModel.areaSecond[@"subFifth"][@"image"]]];
            cell.msDelegate = self;
            return cell;
            break;
        }
        case 1:{
            FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
            cell.model = _shopModel;
            UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClick)];
            UITapGestureRecognizer * tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClickAction)];
            UITapGestureRecognizer * tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagWithClick)];
            //将手势识别器添加到_footer上
            [cell.todayImgView addGestureRecognizer:tapGR];
            [cell.hotImgView addGestureRecognizer:tapGR1];
            [cell.imgView addGestureRecognizer:tapGR2];
            return cell;
            break;
        }
        case 2:{
            SecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
            NSMutableArray * array = [NSMutableArray array];
            NSMutableArray * urlArray = [NSMutableArray array];
            for (int i = 0; i < _shopModel.advList.count; i++) {
                [array addObject:_shopModel.advList[i][@"img"]];
                [urlArray addObject:_shopModel.advList[i][@"url"]];
            }
            DJPageView *pageView = [[DJPageView alloc] initPageViewFrame:CGRectMake(0, 0, cell.frame.size.width, 160) webImageStr:array didSelectPageViewAction:^(NSInteger index) {
                
                HtmlDetailsViewController * htmlDVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"htmld"];
                htmlDVC.urlString = urlArray[index];
                
                [self.navigationController pushViewController:htmlDVC animated:YES];
            }];
            //停留时间
            pageView.duration = 2.0;
            pageView.pageBackgroundColor = [UIColor clearColor];
            pageView.pageIndicatorTintColor = [UIColor orangeColor];
            pageView.currentPageColor = [UIColor blueColor];
            [cell.contentView addSubview:pageView];
            return cell;
            break;
        }
        case 3: {
            TodayHotTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
            
            MovieShopModel * model = _allHotModelArray[indexPath.row];
            
            cell.model = model;
            return cell;
            break;
        }
        default:
            return nil;
            break;
    }
}
//手势事件
- (void)tagClick
{
    HtmlDetailsViewController * htmlDVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"htmld"];
    htmlDVC.urlString = _shopModel.areaSecond[@"subFirst"][@"gotoPage"][@"url"];
    [self.navigationController pushViewController:htmlDVC animated:YES];
}
- (void)tagClickAction
{
    HtmlDetailsViewController * htmlDVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"htmld"];
    htmlDVC.urlString = _shopModel.areaSecond[@"subSecond"][@"gotoPage"][@"url"];
    [self.navigationController pushViewController:htmlDVC animated:YES];
}
- (void)tagWithClick
{
    HtmlDetailsViewController * htmlDVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"htmld"];
    htmlDVC.urlString = _shopModel.areaSecond[@"subThird"][@"gotoPage"][@"url"];
    [self.navigationController pushViewController:htmlDVC animated:YES];
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HtmlDetailsViewController * htmlDVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"htmld"];
    if (indexPath.section == 0) {
        
        htmlDVC.urlString = _shopModel.areaSecond[@"subFifth"][@"gotoPage"][@"url"];
        
        [self.navigationController pushViewController:htmlDVC animated:YES];
    }
    if (indexPath.section == 3) {
        
        FindNewsDetailViewController * findNewsDetailVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil] instantiateViewControllerWithIdentifier:@"newsDetail"];
        
        MovieShopModel * model = _allHotModelArray[indexPath.row];
        
        findNewsDetailVC.homeModel = model;
        findNewsDetailVC.opinionNumber = 1;
        
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:findNewsDetailVC];
        
        [self presentViewController:NC animated:YES completion:nil];
    }
}
//区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }
    return 20;
}
//第三区 区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        
        return @"今日热点";
    }else {
        return nil;
    }
}
//自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
        NSArray * array = @[@"正在热映",@"即将上映",@"找影院"];
        //
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, tableView.frame.size.width/3-10, 50);
        [button setTitle:array[0] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hotAction) forControlEvents:UIControlEventTouchUpInside];
            
        if (_dic[@"totalHotMovie"] != nil) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 20)];
            label.text = [NSString stringWithFormat:@"%@",_dic[@"totalHotMovie"]];
            [button addSubview:label];
        }
        //
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame = CGRectMake(tableView.frame.size.width/3, 0, tableView.frame.size.width/3-10, 50);
        [button1 setTitle:array[1] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(hotAction) forControlEvents:UIControlEventTouchUpInside];
        if (_dic[@"totalComingMovie"] != nil) {
            UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 20)];
            label1.text = [NSString stringWithFormat:@"%@",_dic[@"totalComingMovie"]];
            [button1 addSubview:label1];
        }
        //
        UIButton * button2 = [UIButton buttonWithType:UIButtonTypeSystem];
        button2.frame = CGRectMake(tableView.frame.size.width/3*2, 0, tableView.frame.size.width/3, 50);
        [button2 setTitle:array[2] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(hotAction) forControlEvents:UIControlEventTouchUpInside];
        if (_dic[@"totalCinemaCount"] != nil) {
            UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, 20)];
            label2.text = [NSString stringWithFormat:@"%@",_dic[@"totalCinemaCount"]];
            [button2 addSubview:label2];
        }
        //
        [view addSubview:button];
        [view addSubview:button1];
        [view addSubview:button2];
        return view;
    }
    return nil;
}
- (void)hotAction
{
    self.tabBarController.selectedIndex = 1;
}
- (void)changeViewWithAction
{
    
   self.tabBarController.selectedIndex = 3;
}
- (void)movieShopTableViewCellChangeViewWithAction
{
    self.tabBarController.selectedIndex = 2;
}
@end
