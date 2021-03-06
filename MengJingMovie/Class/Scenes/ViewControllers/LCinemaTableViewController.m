//
//  CinemaTableViewController.m
//  MovieTime2
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import "LCinemaTableViewController.h"
#import "LCinemaTableViewCell.h"
#import "LCinemaModel.h"

#define kTableFrame self.tableView.frame.size.width

@interface LCinemaTableViewController ()

@property(nonatomic,strong)NSArray * array; // 解析出来的数组

@property(nonatomic,strong)NSMutableArray * cinemaArray; // 存放影院model的数组
@property(nonatomic,strong)UIButton * allButton;
@property(nonatomic,strong)UIButton * nearButton;
@property(nonatomic,strong)UIButton * priceButton;
@property(nonatomic,strong)UIButton * screenButton;
@property(nonatomic,strong)LCinemaModel * cinemamodel;
// 已废弃
//@property(nonatomic,strong)NSMutableDictionary * ratingDic; // key=评分，value=model
//@property(nonatomic,strong)NSMutableDictionary * priceDic; // key=价格
//@property(nonatomic,strong)NSMutableArray * ratingArray; // 存放评分的数组
//@property(nonatomic,strong)NSMutableArray * priceArray;  // 存放价格的数组

@property(nonatomic,assign)NSInteger selectCountRating;  // 评分按钮点击次数
@property(nonatomic,assign)NSInteger selectCountPrice; // 价格按钮点击次数
@property(nonatomic,strong)UIView * qutouView;

@end

@implementation LCinemaTableViewController

// 懒加载
- (NSMutableArray *)cinemaArray
{
    if (_cinemaArray == nil) {
        _cinemaArray = [NSMutableArray array];
    }
    return _cinemaArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LCinemaTableViewCell" bundle:nil] forCellReuseIdentifier:@"CinemaCell"];
    // 调用解析数据的方法
    [self requestWithData];
    
    //创建头部视图
    [self headerviewWithimage];
    
    // 创建Button
    [self createButtonAction];
    
    // 给评分和价格按钮的点击次数赋初值
    _selectCountRating = 0;
    _selectCountPrice = 0;
    
    
}

- (void)createButtonAction
{
    _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _allButton.frame = CGRectMake(0, 0, kTableFrame/3, 40);
    
    _allButton.backgroundColor= [UIColor whiteColor];
    
    [_allButton setTitle:@"全部" forState:UIControlStateNormal];
    
    _allButton.tag = 101;
    [_allButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [_allButton addTarget:self action:@selector(didAllButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.nearButton  = [[UIButton alloc] initWithFrame:CGRectMake(kTableFrame/3, 0, kTableFrame/3, 40)];
    _nearButton.backgroundColor = [UIColor whiteColor];
    [_nearButton setTitle:@"评分" forState:UIControlStateNormal];
    
    [_nearButton setTitleColor:[UIColor blackColor]forState: UIControlStateNormal];
    
    [_nearButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    _nearButton.tag = 102;
    [_nearButton addTarget:self action:@selector(nearButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.priceButton = [[UIButton alloc] initWithFrame:CGRectMake(kTableFrame/3 * 2,0, kTableFrame/3, 40)];
    _priceButton.backgroundColor= [UIColor whiteColor];
    
    [_priceButton setTitle:@"价格" forState:UIControlStateNormal];
    
    [_priceButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_priceButton setTitleColor:[UIColor blackColor]forState: UIControlStateNormal];
    
    [_priceButton addTarget:self action:@selector(priceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _priceButton.tag = 103;
    
}

// 创建头部视图
- (void)headerviewWithimage
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTableFrame, 88)];
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kTableFrame, headerView.frame.size.height)];
    webView.backgroundColor = [UIColor redColor];
    NSURL * url = [NSURL URLWithString:kCinemaPicUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [headerView addSubview:webView];
    [self.tableView setTableHeaderView:headerView];

}
// 设置区头高度
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

// 自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.qutouView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTableFrame, 40)];
   
     // 把Button添加到区头视图
    [_qutouView addSubview:_priceButton];
    [_qutouView addSubview:_nearButton];
    [_qutouView addSubview:_allButton];
    return _qutouView;
}



// 点击全部按钮时触发的事件
- (void)didAllButtonAction
{
   
//    if (_cinemaArray.count != 0) {
//        [_cinemaArray removeAllObjects];
//        [self requestWithData]; //
//
//    }else{
//        CLog(@"_cinmemaArray是空");
//    }
    
    
    [_allButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_nearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_priceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
     _cinemaArray = nil;
    [self requestWithData];
    [self.tableView reloadData];
    
}


//点击评分按钮时触发的方法
- (void)nearButtonAction
{
    [_nearButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_priceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

//    [_allButton setTintColor:[UIColor blackColor]];
//    [_priceButton setTintColor:[UIColor blackColor]];
//    [_nearButton setTintColor:[UIColor blueColor]];
#pragma mark ----排序方法1：block排序 compare：从小到大排序(正序排序),如果要倒序排序则 return [s2 compare:s1]
    if (_selectCountRating == 0) {
        [_nearButton setTitle:@"评分⬆️" forState:UIControlStateNormal];
       _selectCountRating ++;
       [_cinemaArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
       LCinemaModel * LC1 = obj1;
       LCinemaModel * LC2 = obj2;
      NSString * s1 = [NSString stringWithFormat:@"%f",LC1.ratingFinal];
      NSString * s2 = [NSString stringWithFormat:@"%f",LC2.ratingFinal];
       return [s1 compare:s2];
   }];
    }
    else
        if(_selectCountRating == 1){
    [_nearButton setTitle:@"评分⬇️" forState:UIControlStateNormal];
    _selectCountRating = 0;
#pragma mark ----排序方法1：NSSortDescriptor排序  YES:从小到大排序(正序排序) NO:从大到小排序(倒序排序)
    NSSortDescriptor * sortDes = [[NSSortDescriptor alloc] initWithKey:@"ratingFinal" ascending:NO];
    NSArray * array = @[sortDes]; // 可以存放多个排序条件
    [_cinemaArray sortUsingDescriptors:array];
    }
    // 刷新列表
    [self.tableView reloadData];
    
}
// 点击价格按钮时触发的方法
- (void)priceButtonAction
{
    [_priceButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (_selectCountPrice == 0) {
    [_priceButton setTitle:@"价格⬆️" forState:UIControlStateNormal];
     
    _selectCountPrice++;
    NSSortDescriptor * sortDes = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:YES];
    NSArray * array = @[sortDes];
    [_cinemaArray sortUsingDescriptors:array];
    }
    else
    if(_selectCountPrice == 1){
        
        [_priceButton setTitle:@"价格⬇️" forState:UIControlStateNormal];
    _selectCountPrice = 0;
    NSSortDescriptor * sortDes = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:NO];
    NSArray * array = @[sortDes];
    [_cinemaArray sortUsingDescriptors:array];
    }
    // 刷新列表
    [self.tableView reloadData];
    
}
#pragma mark ===== 解析数据
- (void)requestWithData
{
    NSURL * url = [NSURL URLWithString:kCinemaUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    __weak LCinemaTableViewController * weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        weakSelf.array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary * dic in _array) {
            
          weakSelf.cinemamodel = [[LCinemaModel alloc] init];
            
          [weakSelf.cinemamodel setValuesForKeysWithDictionary:dic];
        
          [weakSelf.cinemaArray addObject:weakSelf.cinemamodel];
        }

        [self.tableView reloadData]; // 刷新列表

    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}
// 设置cell上显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell" forIndexPath:indexPath];
    LCinemaModel * cinemaModel = _cinemaArray[indexPath.row];
    cell.cinemamodel = cinemaModel;
    return cell;
}



@end
