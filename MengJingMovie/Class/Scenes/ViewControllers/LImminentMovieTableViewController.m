//
//  ImminentMovieTableViewController.m
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import "LImminentMovieTableViewController.h"
#import "LImminentMovieTableViewCell.h"
#import "LImminentModel.h"
#import "DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PrevueViewController.h"


@interface LImminentMovieTableViewController ()

@property(nonatomic,strong)UIView * attentionView;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * peopleLabel;
@property(nonatomic,strong)UILabel * typeLabel;
@property(nonatomic,strong)UILabel * actorLabel;
@property(nonatomic,strong)UIButton * TVButton;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)UIView * certainView;
@property(nonatomic,strong)UILabel * type;
@property(nonatomic,strong)UILabel * dictor;

@property(nonatomic,strong)LImminentModel * imminentModel;
@property(nonatomic,strong)LImminentModel * imminentModel2;

@property(nonatomic,strong)NSMutableArray * attentionArray;  // 存放attentionMovie的model

@property(nonatomic,strong)NSMutableDictionary * monthDic; // 存放月份的字典

@property(nonatomic,strong)LImminentModel * LImodel;  // 模型

@property(nonatomic,strong)MPMoviePlayerViewController * player; // 播放视频的类

@property(nonatomic,assign)BOOL Path;  // 判断的BOOL值

@property(nonatomic,assign)NSIndexPath * indexpath; //

@property(nonatomic,strong)NSString * hightUrl;
@property(nonatomic,strong)NSString * movieName;

@property(nonatomic,strong)LImminentModel * model2;


@end

@implementation LImminentMovieTableViewController

// 懒加载
- (NSMutableArray *)attentionArray
{
    if (_attentionArray == nil) {
        _attentionArray = [NSMutableArray array];
    }
    return _attentionArray;
}
- (NSMutableArray *)comingMovieArray
{
    if (_comingMovieArray == nil) {
        _comingMovieArray =[NSMutableArray array];
    }
    return _comingMovieArray;
    
}
- (NSMutableArray *)monthArray
{
    if (_monthArray == nil) {
        _monthArray = [NSMutableArray array];
    }
    return _monthArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LImminentMovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImminentMovieCell"];
   
    // 调用解析数据的方法
    [self requestDataWithUrl];
    
//    [[ShareAnimationLoad ShareAnimation] animationingLoad:self.view];
    
}

#pragma mark -----解析数据
// 解析数据
- (void)requestDataWithUrl
{
    NSURL * url = [NSURL URLWithString:kImminentUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    __weak LImminentMovieTableViewController * weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        weakSelf.monthDic = [NSMutableDictionary dictionary];
        if (data != nil) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary * dict in dic[@"attention"]) {
                weakSelf.imminentModel = [[LImminentModel alloc] init];
                [_imminentModel setValuesForKeysWithDictionary:dict];
                [weakSelf.attentionArray addObject:weakSelf.imminentModel];
            }

            for (NSDictionary * dict in dic[@"moviecomings"]) {
                weakSelf.imminentModel2 = [[LImminentModel alloc] init];
                [_imminentModel2 setValuesForKeysWithDictionary:dict];
                [weakSelf.comingMovieArray addObject:_imminentModel2];
                if (_imminentModel2.isVideo == 1) {
                _hightUrl = _imminentModel2.videos[0][@"hightUrl"];
                _movieName = _imminentModel2.videos[0][@"title"];
                }
                NSString * month = dict[@"rMonth"];
                // 判断字典是否有这个key值
                if (_monthDic[month]) {
                    NSMutableArray * array = _monthDic[month];
                    [array addObject:_imminentModel2];
                    [_monthDic setValue:array forKey:month];
                    
                }else{
                    NSMutableArray * array = [NSMutableArray array];
                    [array addObject:_imminentModel2];
                    [_monthDic setValue:array forKey:month];
                }
            }
            // 把_monthDic中的所有key存到数组中
            [weakSelf.monthArray addObjectsFromArray:_monthDic.allKeys];
            // 对key进行排序
#warning ----------对数组进行排序的方法,应该用sortUsingSelector和sortedArrayUsingSelector混淆了，
//  [_monthArray sortedArrayUsingSelector:@selector(compare:)]  // 对不可变数组进行排序
    [_monthArray sortUsingSelector:@selector(compare:)]; // 对可变数组进行排序
            CLog(@"*******%@",_monthArray);
            if (_monthArray != nil) {
                
                NSInteger num1 = [_monthArray[0] integerValue];
                NSInteger num2 = [_monthArray[1] integerValue];
                NSInteger num3 = [_monthArray[2] integerValue];
                
                if (num1 == 1 && num2 == 11 && num3 == 12) {
                     // 根据下标交换数组中的元素
                     [_monthArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
                    [_monthArray exchangeObjectAtIndex:1 withObjectAtIndex:2];
                }else if(num1 == 1 && num2 == 12&& num3 == 2) {
                    [_monthArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
                }else{

                }
            }
            
            [self.tableView reloadData];// 刷新
            // 加载完成，隐藏动画
//            [[ShareAnimationLoad ShareAnimation] animationSuccessLoad];
        }
    //   调用创建轮播图的方法
        [self cycleScrollView];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
// 设置多少分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _monthArray.count;
}
// 设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_monthDic[_monthArray[section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LImminentMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImminentMovieCell" forIndexPath:indexPath];
    _LImodel  = _monthDic[_monthArray[indexPath.section]][indexPath.row];
    cell.imminentModel = _LImodel;
    
    [cell.buttonImage addTarget:self action:@selector(btnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
// button 的点击事件
- (void)btnClick:(id)sender event:(id)event{
    NSSet * touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    LImminentModel * model = _monthDic[_monthArray[indexPath.section]][indexPath.row];
    if (model.isVideo == 0) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此电影暂时没有预告片哦!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alertView show];
        CLog(@"无预告片");
    }else if (model.isVideo == 1){
        PrevueViewController * prevueVC = [[UIStoryboard storyboardWithName:@"Show" bundle:nil] instantiateViewControllerWithIdentifier:@"PrevueVC"];
        prevueVC.hightUrl = model.videos[0][@"hightUrl"];
        prevueVC.movieName = model.title;
        [self showViewController:prevueVC sender:Nil];
    }
}

// 点击cell时触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _model2 = _monthDic[_monthArray[indexPath.section]][indexPath.row];
    DetailViewController * DetailVC = [[UIStoryboard storyboardWithName:@"Show" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailMovieVC"];
    _indexpath = indexPath;
    DetailVC.LIModel = _model2;
    DetailVC.panduan = NO;
    [self.navigationController pushViewController:DetailVC animated:YES];
}
// 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  40;
}
// 区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
#warning -------因为rMonth数据类型是整型，所以要将整型转为字符型
    return [NSString stringWithFormat:@"%@月",_monthArray[section]];
}


// 轮播图
- (void)cycleScrollView
{
    // tap手势
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushDetailAction)];
    // 创建attentionView
    self.attentionView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.tableView.frame.size.width, 180)];
    _attentionView.backgroundColor = [UIColor colorWithRed:111.0/255 green:208.0/255 blue:112.0/255 alpha:0.7];
    // 将手势添加到attentionView中
//    [_attentionView addGestureRecognizer:tapGesture];
    
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _attentionView.frame.size.width, 180)];
    // 创建pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3+45, 150, 150, 30)];
    // 设置未选中圆点的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    // 设置当前选中圆点的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.0/255 green:100.0/255 blue:242.0/255 alpha:1.0];
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    
    for (int i = 0; i < _attentionArray.count; i ++) {
        
        self.certainView = [[UIView alloc] init];
        CGFloat certainX = i * width;
        CGFloat certainY = 0.f;
        _certainView.frame = CGRectMake(certainX, certainY, width, height);
        
        // 调用创建控件的方法
        [self createSubViewAndLayout];
        // 给轮播图赋值
        LImminentModel * model = _attentionArray[i];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
        self.titleLabel.text = model.title;
        self.peopleLabel.text = [NSString stringWithFormat:@"%ld 人想看",model.wantedCount];
        self.typeLabel.text = model.type;
        self.actorLabel.text = model.director;
        [self.certainView addSubview:_imgView];
        [_certainView addSubview:_imgView];
        [_certainView addSubview:_titleLabel];
        [_certainView addSubview:_peopleLabel];
        [_certainView addSubview:_typeLabel];
        [_certainView addSubview:_actorLabel];
        [_certainView addSubview:_type];
        [_certainView addSubview:_dictor];
        
        [self.scrollView addSubview:_certainView];
    }
    self.scrollView.contentSize = CGSizeMake(_attentionArray.count * width, 0);
    // 设置是否有分页效果
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    //  设置总页数
    self.pageControl.numberOfPages = _attentionArray.count;
    self.pageControl.currentPage = 1;

    [_attentionView addSubview:self.scrollView];
    [_attentionView addSubview:self.pageControl];
    
    [self.tableView setTableHeaderView:_attentionView];
    
}

#pragma mark ---- 实现UIScrollViewDelegate中的方法
// 轮播图scrollView滚动时执行的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    CGFloat offsetX = offset.x;
    CGFloat width = self.scrollView.frame.size.width;
#warning ----------------------------------pagecontrol上的点应该跟这个有关系
    int pageNum = (offsetX + .5f * width)/width;
    self.pageControl.currentPage = pageNum;
}
// 创建attentionView上的控件并布局
- (void)createSubViewAndLayout
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width/3, 170)];
    self.imgView.backgroundColor = [UIColor redColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3+15, 5, 200, 30)];
    self.peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3+15, 45, 100, 30)];
    self.type = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3+15, 80, 40, 30)];
    _type.text = @"类型:";
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3+60, 80, 155, 30)];
    self.dictor = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3+15, 115, 40, 30)];
    _dictor.text = @"导演:";
    self.actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3+60, 115, 155, 30)];
   
}

// attentionView推出电影详情界面
- (void)pushDetailAction
{
}


@end