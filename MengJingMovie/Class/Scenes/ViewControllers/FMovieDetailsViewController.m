//
//  FMovieDetailsViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FMovieDetailsViewController.h"
#import "FMovieDetailsCell.h"
#import "CommentsModel.h"
#import "DetailsView.h"
#import "UMSocial.h"

@interface FMovieDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,shareRequestDataDateSource>


@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;//网友评论

@property(nonatomic, assign)NSInteger index;//下拉刷新
@property(nonatomic, strong)NSMutableArray * allCommentsArray;//存放model对象

@property(nonatomic, strong)NSMutableDictionary * dic;//解析数据字典

@end

@implementation FMovieDetailsViewController
//懒加载
- (NSMutableArray *)allCommentsArray
{
    if (_allCommentsArray == nil) {
        
        _allCommentsArray = [NSMutableArray array];
    }
    return _allCommentsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    UINib * nib = [UINib nibWithNibName:@"FMovieDetailsCell" bundle:nil];
    [self.commentsTableView registerNib:nib forCellReuseIdentifier:@"detailsCell"];
    //显示数据
    [self showData];
    _index = 1;//初始化
    //绑定代理
    ShareRequestData * handle = [[ShareRequestData alloc] initWithUrlByString:kCommentsUrl(_model.movieId, _index)];
    handle.datesource = self;
    //绑定代理
    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    //加载效果
    [[ShareAnimationLoad ShareAnimation] animationingLoad:self.view];
    
    //上拉刷新
    self.commentsTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         _index++;
        if (_index < 20) {
            ShareRequestData * handle = [[ShareRequestData alloc] initWithUrlByString:kCommentsUrl(_model.movieId, _index)];
            handle.datesource = self;
        }
    }];
}
#pragma mark ---设置tableView头部和显示数据
- (void)showData
{
    DetailsView * dView = [[NSBundle mainBundle] loadNibNamed:@"DetailsView" owner:self options:nil].firstObject;
    
    self.commentsTableView.tableHeaderView = dView;
    
    [dView.movieImgView sd_setImageWithURL:[NSURL URLWithString:_model.img]];
    dView.titleLabel.text = _model.titleCn;
    dView.subtitleLabel.text = _model.titleEn;
    dView.movieTimeLabel.text = [NSString stringWithFormat:@"%ld",_model.length];
    dView.ratingLabel.text = [NSString stringWithFormat:@"%.1f",_model.ratingFinal];
    dView.categoryLabel.text = _model.type;
    dView.timeLabel.text = [NSString stringWithFormat:@"%ld年%ld月%ld日中国上映",_model.rYear,_model.rMonth,_model.rDay];
    dView.descLabel.text = _model.commonSpecial;
    dView.directorLabel.text = _model.directorName;
    dView.actorLabel.text = _model.actorName1;
    dView.actorLabel1.text = _model.actorName2;
}
//返回
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareAction:(id)sender {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5613b714e0f55a347a008968"
                                      shareText:@"快把好看的电影,分享给好友;好东西,大家一起分享"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,nil]
                                       delegate:nil];
}

#pragma mark ----实现协议方法
- (void)shareRequestData:(ShareRequestData *)requestHandle didSucceedWithData:(NSData *)data
{
    if (data != nil) {
        [[ShareAnimationLoad ShareAnimation] animationSuccessLoad];
        self.dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary * dict in _dic[@"cts"]) {
            
            CommentsModel * model = [CommentsModel new];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.allCommentsArray addObject:model];
        }
         [self.commentsTableView.footer endRefreshing];
        [self.commentsTableView reloadData];
    }
}
#pragma mark ---实现tableView协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allCommentsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsModel * model = _allCommentsArray[indexPath.row];
    CGFloat height = [FMovieDetailsCell getTextHeight:model.ce];
    return height+66;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_dic[@"totalCount"] == nil) {
        return [NSString stringWithFormat:@"网友评论(暂无)"];
    } else {
        return [NSString stringWithFormat:@"网友评论(%@)",_dic[@"totalCount"]];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMovieDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailsCell" forIndexPath:indexPath];
    
    CommentsModel * model = _allCommentsArray[indexPath.row];
    
    cell.cmodel = model;

    return cell;
}



@end
