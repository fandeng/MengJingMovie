//
//  ZShopViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "ZModel.h"
#import "MJRefresh.h"
#import "TopicView.h"
#import "DJPageView.h"
#import "CategoryView.h"
#import "goodsCollectionViewCell.h"
#import "ShareRequestData.h"
#import "ZShopViewController.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"

#define kWidth self.view.frame.size.width

@interface ZShopViewController () <UIScrollViewDelegate, shareRequestDataDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, shareRequestDataDateSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIView *Navigation;
@property (strong, nonatomic) NSDictionary *bigDic;
@property (strong, nonatomic) TopicView *TV;
@property (strong, nonatomic) CategoryView *CGV1;
@property (strong, nonatomic) CategoryView *CGV2;
@property (strong, nonatomic) CategoryView *CGV3;
@property (strong, nonatomic) CategoryView *CGV4;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *cellAImage;
@property (weak, nonatomic) IBOutlet UIImageView *cellBImage;
@property (weak, nonatomic) IBOutlet UIImageView *cellCImage;
@property (weak, nonatomic) IBOutlet UIImageView *cellDImage;
@property (strong, nonatomic) NSMutableArray * goodsArray;
@property (strong, nonatomic) UICollectionView * CollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (assign, nonatomic) NSInteger count;
@property (weak, nonatomic) IBOutlet UIImageView *tap1;
@property (weak, nonatomic) IBOutlet UIImageView *tap2;
@property (weak, nonatomic) IBOutlet UIImageView *tap3;
@property (weak, nonatomic) IBOutlet UIImageView *tap4;
@property (weak, nonatomic) IBOutlet UITextField *seachView;
@property (assign, nonatomic) int secondsCountDown;
@property (strong, nonatomic) UILabel * labelText;
@property (strong, nonatomic) NSTimer * countDownTimer;

@end

@implementation ZShopViewController
//  字典懒加载
- (NSDictionary *)bigDic {
    if (_bigDic == nil) {
        _bigDic = [NSDictionary dictionary];
    }
    return _bigDic;
}
//  数组懒加载
- (NSMutableArray *)goodsArray {
    if (_goodsArray == nil) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}
//  viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
//  大滚动视图设置
    _Navigation.alpha = 0;
    _ScrollView.bounces = NO;
    _ScrollView.delegate = self;
    _ScrollView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
//  搜索栏设置
    _seachView.delegate = self;
    _seachView.clearsOnBeginEditing = YES;
    _seachView.returnKeyType = UIReturnKeySearch;
    _seachView.clearButtonMode = UITextFieldViewModeWhileEditing;
//  解析数据
    ShareRequestData * handle1 = [[ShareRequestData alloc] initWithUrlByString:kUrl];
    handle1.delegate = self;
    _count = 1;
    NSString * str = @"101344%2C101332%2C100853";
    ShareRequestData * handle2 = [[ShareRequestData alloc] initWithUrlByString:kGoods];
    handle2.datesource = self;
//  页面布局
    [self.view layoutIfNeeded];
    self.TV = [[[NSBundle mainBundle] loadNibNamed:@"TopicView" owner:nil options:nil] firstObject];
    _TV.frame = CGRectMake(0, self.cellView.frame.origin.y+_cellView.frame.size.height, kWidth, 568);
    [self.myView addSubview:_TV];
    
    self.CGV1 = [[[NSBundle mainBundle] loadNibNamed:@"Category" owner:nil options:nil] firstObject];
    _CGV1.frame = CGRectMake(0, _TV.frame.origin.y+_TV.frame.size.height, kWidth, 330);
    [_myView addSubview:_CGV1];
    
    self.CGV2 = [[[NSBundle mainBundle] loadNibNamed:@"Category" owner:nil options:nil] firstObject];
    _CGV2.frame = CGRectMake(0, _CGV1.frame.origin.y+_CGV1.frame.size.height, kWidth, 330);
    [_myView addSubview:_CGV2];
    
    self.CGV3 = [[[NSBundle mainBundle] loadNibNamed:@"Category" owner:nil options:nil] firstObject];
    _CGV3.frame = CGRectMake(0, _CGV2.frame.origin.y+_CGV2.frame.size.height, kWidth, 330);
    [_myView addSubview:_CGV3];
    
    self.CGV4 = [[[NSBundle mainBundle] loadNibNamed:@"Category" owner:nil options:nil] firstObject];
    _CGV4.frame = CGRectMake(0, _CGV3.frame.origin.y+_CGV3.frame.size.height, kWidth, 330);
    [_myView addSubview:_CGV4];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, _CGV4.frame.origin.y+_CGV4.frame.size.height, kWidth, 20)];
    label.text = @"——————————你可能感兴趣的——————————";
    [label setFont:[UIFont systemFontOfSize:11]];
    [label setTextColor:[UIColor grayColor]];
    label.textAlignment = NSTextAlignmentCenter;
    [_myView addSubview:label];
//  集合视图
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.CollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, label.frame.origin.y+label.frame.size.height, kWidth, 1160) collectionViewLayout:layout];
    _CollectionView.delegate = self;
    _CollectionView.dataSource = self;
    _CollectionView.backgroundColor = [UIColor whiteColor];
    [_myView addSubview:_CollectionView];
    UINib * nib = [UINib nibWithNibName:@"goodsCollectionViewCell" bundle:nil];
    [_CollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
//  动态指定大滚动视图高度
    self.scrollViewHeight.constant = _CollectionView.frame.origin.y+_CollectionView.frame.size.height;
//  添加手势
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick1)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick2)];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick3)];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick4)];
    _tap1.userInteractionEnabled = YES;
    _tap2.userInteractionEnabled = YES;
    _tap3.userInteractionEnabled = YES;
    _tap4.userInteractionEnabled = YES;
    [_tap1 addGestureRecognizer:tap1];
    [_tap2 addGestureRecognizer:tap2];
    [_tap3 addGestureRecognizer:tap3];
    [_tap4 addGestureRecognizer:tap4];
}
//  键盘控制
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [_seachView resignFirstResponder];
    } else {
        WebViewController * WV = [[WebViewController alloc] init];
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
        NSString * type = [_seachView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        WV.url = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/#!/commerce/list/?q=%@", type];
        [self presentViewController:NC animated:YES completion:nil];
    }
    return YES;
}
//  玩具按钮点击事件 推出详情
- (void)didClick1 {
    NSArray * array = _bigDic[@"navigatorIcon"];
    NSDictionary * dic = array[0];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/%@", dic[@"url"]];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  数码按钮点击事件 推出详情
- (void)didClick2 {
    NSArray * array = _bigDic[@"navigatorIcon"];
    NSDictionary * dic = array[1];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/%@", dic[@"url"]];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  服饰按钮点击事件 推出详情
- (void)didClick3 {
    NSArray * array = _bigDic[@"navigatorIcon"];
    NSDictionary * dic = array[2];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/%@", dic[@"url"]];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  家居按钮点击事件 推出详情
- (void)didClick4 {
    NSDictionary * dic = _bigDic[@"navigatorFirthIcon"];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/%@", dic[@"url"]];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  上拉加载更多
- (void)footerRefresh {
    if (_count >= _goodsArray.count/10) {
        _count++;
        NSInteger a = _goodsArray.count;
        if (a % 2 != 0) {
            a = a + 1;
        }
        NSString * str = @"101344%2C101332%2C100853";
        ShareRequestData * handle = [[ShareRequestData alloc] initWithUrlByString:kGoods];
        handle.datesource = self;
        _CollectionView.frame = CGRectMake(0, _CollectionView.frame.origin.y, kWidth, 220*(a/2)+10*(a/2+1));
        _scrollViewHeight.constant = _CollectionView.frame.origin.y+_CollectionView.frame.size.height;
        [_ScrollView.footer endRefreshing];
    } else {
        _ScrollView.footer.hidden = YES;
    }}
//  解析数据
- (void)shareRequestData:(ShareRequestData *)requestHandle didSucceedWithData:(NSData *)data {
    if (data != nil) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * array1 = dic[@"goodsList"];
        for (NSDictionary * dict in array1) {
            ZModel * model = [[ZModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.goodsArray addObject:model];
        }
        [self.CollectionView reloadData];
    }
}
//  集合视图item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kWidth/2-15, 220);
}
//  集合视图item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _goodsArray.count;
}
//  集合视图item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    goodsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ZModel * model = _goodsArray[indexPath.row];
    [cell.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.nameLabel.text = model.name;
    if (kWidth == 375) {
        [cell.nameLabel setFont:[UIFont systemFontOfSize:13]];
    } else if (kWidth == 320) {
        [cell.nameLabel setFont:[UIFont systemFontOfSize:12]];
    } else {
        [cell.nameLabel setFont:[UIFont systemFontOfSize:14]];
    }
    cell.moneyLabel.text = [NSString stringWithFormat:@"¥%ld", model.minSalePrice/100];
    cell.typeLabel.text = model.iconText;
    return cell;
}
//  解析数据
- (void)shareRequestHandle:(ShareRequestData *)requestHandle data:(NSData *)data {
    if (data != nil) {
        self.bigDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self createCellABCD];
        [self createTopicView];
        [self createScrollView];
        [self createSmallTopicView];
        [self createTopicViewMoreGoods];
        [self createCategoryView];
    }
}
//  创建类型板块
- (void)createCategoryView {
    NSArray * array2 = _bigDic[@"category"];
    int i = 0;
    for (NSDictionary * dic in array2) {
        if (i == 0) {
            [_CGV1.bigImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
            _CGV1.titleLabel.text = dic[@"name"];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 500 + i;
            button.frame = CGRectMake(0, 0, _CGV1.bigImgView.frame.size.width, _CGV1.bigImgView.frame.size.height);
            [button addTarget:self action:@selector(didClickButton2:) forControlEvents:UIControlEventTouchDown];
            [_CGV1.bigImgView addSubview:button];
            _CGV1.bigImgView.userInteractionEnabled = YES;
            UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button1.tag = 600 + i;
            button1.frame = CGRectMake(0, 0, _CGV1.moreLabel.frame.size.width, _CGV1.moreLabel.frame.size.height);
            [button1 addTarget:self action:@selector(didClickButton4:) forControlEvents:UIControlEventTouchDown];
            [_CGV1.moreLabel addSubview:button1];
            _CGV1.moreLabel.userInteractionEnabled = YES;
            NSArray * array3 = dic[@"subList"];
            int j = 0;
            for (NSDictionary * dict in array3) {
                if (j == 0) {
                    [_CGV1.smallImgView1 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV1.label1.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV1.smallImgView1.frame.size.width, _CGV1.smallImgView1.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV1.smallImgView1 addSubview:button];
                    _CGV1.smallImgView1.userInteractionEnabled = YES;
                }
                if (j == 1) {
                    [_CGV1.smallImgView2 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV1.label2.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV1.smallImgView2.frame.size.width, _CGV1.smallImgView2.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV1.smallImgView2 addSubview:button];
                    _CGV1.smallImgView2.userInteractionEnabled = YES;
                }
                if (j == 2) {
                    [_CGV1.smallImgView3 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV1.label3.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV1.smallImgView3.frame.size.width, _CGV1.smallImgView3.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV1.smallImgView3 addSubview:button];
                    _CGV1.smallImgView3.userInteractionEnabled = YES;
                }
                j++;
            }
        }
        if (i == 1) {
            [_CGV2.bigImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
            _CGV2.titleLabel.text = dic[@"name"];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 500 + i;
            button.frame = CGRectMake(0, 0, _CGV2.bigImgView.frame.size.width, _CGV2.bigImgView.frame.size.height);
            [button addTarget:self action:@selector(didClickButton2:) forControlEvents:UIControlEventTouchDown];
            [_CGV2.bigImgView addSubview:button];
            _CGV2.bigImgView.userInteractionEnabled = YES;
            UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button1.tag = 600 + i;
            button1.frame = CGRectMake(0, 0, _CGV2.moreLabel.frame.size.width, _CGV2.moreLabel.frame.size.height);
            [button1 addTarget:self action:@selector(didClickButton4:) forControlEvents:UIControlEventTouchDown];
            [_CGV2.moreLabel addSubview:button1];
            _CGV2.moreLabel.userInteractionEnabled = YES;
            NSArray * array4 = dic[@"subList"];
            int j = 0;
            for (NSDictionary * dict in array4) {
                if (j == 0) {
                    [_CGV2.smallImgView1 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV2.label1.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV2.smallImgView1.frame.size.width, _CGV2.smallImgView1.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV2.smallImgView1 addSubview:button];
                    _CGV2.smallImgView1.userInteractionEnabled = YES;
                }
                if (j == 1) {
                    [_CGV2.smallImgView2 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV2.label2.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV2.smallImgView2.frame.size.width, _CGV2.smallImgView2.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV2.smallImgView2 addSubview:button];
                    _CGV2.smallImgView2.userInteractionEnabled = YES;
                }
                if (j == 2) {
                    [_CGV2.smallImgView3 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV2.label3.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV2.smallImgView3.frame.size.width, _CGV2.smallImgView3.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV2.smallImgView3 addSubview:button];
                    _CGV2.smallImgView3.userInteractionEnabled = YES;
                }
                j++;
            }
        }
        if (i == 2) {
            [_CGV3.bigImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
            _CGV3.titleLabel.text = dic[@"name"];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 500 + i;
            button.frame = CGRectMake(0, 0, _CGV3.bigImgView.frame.size.width, _CGV3.bigImgView.frame.size.height);
            [button addTarget:self action:@selector(didClickButton2:) forControlEvents:UIControlEventTouchDown];
            [_CGV3.bigImgView addSubview:button];
            _CGV3.bigImgView.userInteractionEnabled = YES;
            UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button1.tag = 600 + i;
            button1.frame = CGRectMake(0, 0, _CGV3.moreLabel.frame.size.width, _CGV3.moreLabel.frame.size.height);
            [button1 addTarget:self action:@selector(didClickButton4:) forControlEvents:UIControlEventTouchDown];
            [_CGV3.moreLabel addSubview:button1];
            _CGV3.moreLabel.userInteractionEnabled = YES;
            NSArray * array5 = dic[@"subList"];
            int j = 0;
            for (NSDictionary * dict in array5) {
                if (j == 0) {
                    [_CGV3.smallImgView1 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV3.label1.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV3.smallImgView1.frame.size.width, _CGV3.smallImgView1.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV3.smallImgView1 addSubview:button];
                    _CGV3.smallImgView1.userInteractionEnabled = YES;
                }
                if (j == 1) {
                    [_CGV3.smallImgView2 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV3.label2.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV3.smallImgView2.frame.size.width, _CGV3.smallImgView2.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV3.smallImgView2 addSubview:button];
                    _CGV3.smallImgView2.userInteractionEnabled = YES;
                }
                if (j == 2) {
                    [_CGV3.smallImgView3 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV3.label3.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV3.smallImgView3.frame.size.width, _CGV3.smallImgView3.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV3.smallImgView3 addSubview:button];
                    _CGV3.smallImgView3.userInteractionEnabled = YES;
                }
                j++;
            }
        }
        if (i == 3) {
            [_CGV4.bigImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
            _CGV4.titleLabel.text = dic[@"name"];
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 500 + i;
            button.frame = CGRectMake(0, 0, _CGV4.bigImgView.frame.size.width, _CGV4.bigImgView.frame.size.height);
            [button addTarget:self action:@selector(didClickButton2:) forControlEvents:UIControlEventTouchDown];
            [_CGV4.bigImgView addSubview:button];
            _CGV4.bigImgView.userInteractionEnabled = YES;
            UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button1.tag = 600 + i;
            button1.frame = CGRectMake(0, 0, _CGV4.moreLabel.frame.size.width, _CGV4.moreLabel.frame.size.height);
            [button1 addTarget:self action:@selector(didClickButton4:) forControlEvents:UIControlEventTouchDown];
            [_CGV4.moreLabel addSubview:button1];
            _CGV4.moreLabel.userInteractionEnabled = YES;
            NSArray * array6 = dic[@"subList"];
            int j = 0;
            for (NSDictionary * dict in array6) {
                if (j == 0) {
                    [_CGV4.smallImgView1 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV4.label1.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV4.smallImgView1.frame.size.width, _CGV4.smallImgView1.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV4.smallImgView1 addSubview:button];
                    _CGV4.smallImgView1.userInteractionEnabled = YES;
                }
                if (j == 1) {
                    [_CGV4.smallImgView2 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV4.label2.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV4.smallImgView2.frame.size.width, _CGV4.smallImgView2.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV4.smallImgView2 addSubview:button];
                    _CGV4.smallImgView2.userInteractionEnabled = YES;
                }
                if (j == 2) {
                    [_CGV4.smallImgView3 sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                    _CGV4.label3.text = dict[@"title"];
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = 500 + 10 * i + j;
                    button.frame = CGRectMake(0, 0, _CGV4.smallImgView3.frame.size.width, _CGV4.smallImgView3.frame.size.height);
                    [button addTarget:self action:@selector(didClickButton3:) forControlEvents:UIControlEventTouchDown];
                    [_CGV4.smallImgView3 addSubview:button];
                    _CGV4.smallImgView3.userInteractionEnabled = YES;
                }
                j++;
            }
        }
        i++;
    }
}
//  类型板块more点击事件 推出详情
- (void)didClickButton4:(UIButton *)button1 {
    NSArray * array = _bigDic[@"category"];
    NSMutableArray * urlArray = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/%@", dic[@"moreUrl"]];
        [urlArray addObject:str];
    }
    for (int i = 0; i < array.count; i++) {
        if (button1.tag == 600 + i) {
            WebViewController * WV = [[WebViewController alloc] init];
            UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
            WV.url = urlArray[i];
            [self presentViewController:NC animated:YES completion:nil];
        }
    }
}
//  类型板块cell2点击事件 推出详情
- (void)didClickButton3:(UIButton *)button {
    NSArray * array = _bigDic[@"category"];
    NSMutableArray * urlArray = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        NSArray * subArray = dic[@"subList"];
        for (NSDictionary * dict in subArray) {
            NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/#!/commerce/item/%@/", dict[@"goodsId"]];
            [urlArray addObject:str];
        }
    }
    for (int i = 0; i < array.count; i++) {
        for (int j = 0; j < 3; j++) {
            if (button.tag == 500+10*i+j) {
                WebViewController * WV = [[WebViewController alloc] init];
                UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
                WV.url = urlArray[10*i+j-i*7];
                [self presentViewController:NC animated:YES completion:nil];
            }
        }
    }
}
//  类型板块cell1点击事件 推出详情
- (void)didClickButton2:(UIButton *)button {
    NSArray * array = _bigDic[@"category"];
    NSMutableArray * urlArray = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        //        NSArray * strArray = [dic[@"imageUrl"] componentsSeparatedByString:@"q="];
        //        NSString * type = [strArray[1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        NSString * url = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/#!/commerce/list/?q=%@", type];
        NSString * url = dic[@"imageUrl"];
        [urlArray addObject:url];
    }
    for (int i = 0; i < array.count; i++) {
        if (button.tag == 500 + i) {
            WebViewController * WV = [[WebViewController alloc] init];
            UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
            WV.url = urlArray[i];
            [self presentViewController:NC animated:YES completion:nil];
        }
    }}
//  创建cellABCD板块
- (void)createCellABCD {
    NSDictionary * cellAdic = _bigDic[@"cellA"];
    NSString * cellAImgUrl = cellAdic[@"img"];
    [_cellAImage sd_setImageWithURL:[NSURL URLWithString:cellAImgUrl]];
    //  创建倒计时器
    if ([cellAdic[@"longTime"] doubleValue] != 0) {
        self.labelText = [[UILabel alloc] initWithFrame:CGRectMake(0, _cellAImage.frame.size.height-30, _cellAImage.frame.size.width, 30)];
        NSDate * date1 = [NSDate dateWithTimeIntervalSinceNow:+3600*8];
        NSTimeInterval time = [cellAdic[@"longTime"] doubleValue]+3600*8;
        NSDate * date2 = [NSDate dateWithTimeIntervalSince1970:time];
        NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
        _secondsCountDown = interval;
        _labelText.backgroundColor = [UIColor blackColor];
        _labelText.alpha = 0.7;
        [_labelText setTextColor:[UIColor whiteColor]];
        [_labelText setFont:[UIFont systemFontOfSize:25]];
        _labelText.textAlignment = NSTextAlignmentCenter;
        [_cellAImage addSubview:_labelText];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    }
    NSDictionary * cellBdic = _bigDic[@"cellB"];
    NSString * cellBImgUrl = cellBdic[@"img"];
    [_cellDImage sd_setImageWithURL:[NSURL URLWithString:cellBImgUrl]];
    NSDictionary * cellCdic = _bigDic[@"cellC"];
    NSArray * cellArray = cellCdic[@"list"];
    NSDictionary * dict1 = cellArray[0];
    NSDictionary * dict2 = cellArray[1];
    [_cellBImage sd_setImageWithURL:dict1[@"image"]];
    [_cellCImage sd_setImageWithURL:dict2[@"image"]];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick5)];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick6)];
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick7)];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick8)];
    _cellAImage.userInteractionEnabled = YES;
    _cellBImage.userInteractionEnabled = YES;
    _cellCImage.userInteractionEnabled = YES;
    _cellDImage.userInteractionEnabled = YES;
    [_cellAImage addGestureRecognizer:tap1];
    [_cellBImage addGestureRecognizer:tap2];
    [_cellCImage addGestureRecognizer:tap3];
    [_cellDImage addGestureRecognizer:tap4];
}
//  计时器事件
- (void)timeFireMethod {
    _secondsCountDown --;
    int hour = _secondsCountDown/3600;
    int minute = (_secondsCountDown-hour*3600)/60;
    int second = _secondsCountDown-hour*3600-minute*60;
    NSString * dural = [NSString stringWithFormat:@"%02d : %02d : %02d", hour, minute, second];
    _labelText.text = dural;
    if (_secondsCountDown == 0) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        [_labelText removeFromSuperview];
    }
}
//  cellA点击事件 推出详情
- (void)didClick5 {
    NSDictionary * dic = _bigDic[@"cellA"];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/%@", dic[@"url"]];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  cellB点击事件 推出详情
- (void)didClick6 {
    NSDictionary * dic = _bigDic[@"cellC"];
    NSArray * array = dic[@"list"];
    NSDictionary * dict = array[0];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = dict[@"url"];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  cellC点击事件 推出详情
- (void)didClick7 {
    NSDictionary * dic = _bigDic[@"cellC"];
    NSArray * array = dic[@"list"];
    NSDictionary * dict = array[1];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = dict[@"url"];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  cellD点击事件 推出详情
- (void)didClick8 {
    NSDictionary * dic = _bigDic[@"cellB"];
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    NSString * str = dic[@"url"];
    WV.url = str;
    [self presentViewController:NC animated:YES completion:nil];
}
//  创建主题板块
- (void)createTopicView {
    NSArray * array7 = _bigDic[@"topic"];
    self.TV.topicScrollView.contentSize = CGSizeMake(kWidth*array7.count, _TV.topicScrollView.frame.size.height);
    _TV.topicScrollView.showsHorizontalScrollIndicator = NO;
    int i = 0;
    for (NSDictionary * dic in array7) {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kWidth, 0, kWidth, _TV.topicScrollView.frame.size.height)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"backgroupImage"]]];
        [_TV.topicScrollView addSubview:imgView];
        i++;
    }
}
//  创建轮播图
- (void)createScrollView {
    NSArray * array8 = _bigDic[@"scrollImg"];
    NSMutableArray * scrollImgArray = [NSMutableArray array];
    NSMutableArray * urlArray = [NSMutableArray array];
    for (NSDictionary * dic in array8) {
        [scrollImgArray addObject:dic[@"image"]];
        [urlArray addObject:dic[@"url"]];
    }
    DJPageView * pageView = [[DJPageView alloc] initPageViewFrame:CGRectMake(0, 0, kWidth, self.view.frame.size.height/5*2) webImageStr:scrollImgArray didSelectPageViewAction:^(NSInteger index) {
        WebViewController * WV = [[WebViewController alloc] init];
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
        WV.url = urlArray[index];
        [self presentViewController:NC animated:YES completion:nil];
    }];
    [self.myView addSubview:pageView];
}
//  创建主题板块的选择按钮
- (void)createSmallTopicView {
    NSArray * array9 = _bigDic[@"topic"];
    self.TV.smallTopicScroll.contentSize = CGSizeMake(kWidth/4*array9.count, _TV.smallTopicScroll.frame.size.height);
    _TV.smallTopicScroll.showsHorizontalScrollIndicator = NO;
    _TV.smallTopicScroll.bounces = NO;
    int i = 0;
    for (NSDictionary * dic in array9) {
        UIView * cellview = [[UIView alloc] initWithFrame:CGRectMake(i*kWidth/4, 0, kWidth/4, _TV.smallTopicScroll.frame.size.height)];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.bounds = CGRectMake(0, 0, 60, 60);
        button.center = CGPointMake(cellview.frame.size.width/2, cellview.frame.size.height/2);
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dic[@"uncheckImage"]] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                [button setBackgroundImage:image forState:UIControlStateNormal];
            }
        }];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dic[@"checkedImage"]] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                [button setBackgroundImage:image forState:UIControlStateHighlighted];
            }
        }];
        [cellview addSubview:button];
        [_TV.smallTopicScroll addSubview:cellview];
        i++;
    }
}
//  创建主题板块的更多商品
- (void)createTopicViewMoreGoods {
    NSArray * array10 = _bigDic[@"topic"];
    self.TV.bigTopicScroll.contentSize = CGSizeMake(kWidth*array10.count, _TV.bigTopicScroll.frame.size.height);
    _TV.bigTopicScroll.showsHorizontalScrollIndicator = NO;
    int i = 0;
    for (NSDictionary * dic in array10) {
        UIView * cellview = [[UIView alloc] initWithFrame:CGRectMake(i*kWidth, 0, kWidth, _TV.bigTopicScroll.frame.size.height)];
        UILabel * ENlabel = [[UILabel alloc] init];
        ENlabel.textAlignment = NSTextAlignmentCenter;
        ENlabel.bounds = CGRectMake(0, 0, 250, 20);
        ENlabel.center = CGPointMake(cellview.frame.size.width/2, 10);
        ENlabel.text = dic[@"titleEn"];
        UILabel * CNlabel = [[UILabel alloc] init];
        CNlabel.textAlignment = NSTextAlignmentCenter;
        CNlabel.bounds = CGRectMake(0, 0, 250, 30);
        CNlabel.center = CGPointMake(cellview.frame.size.width/2, 30);
        CNlabel.text = dic[@"titleCn"];
        [CNlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19]];
        [cellview addSubview:ENlabel];
        [cellview addSubview:CNlabel];

        NSArray * subArray = dic[@"subList"];
        int j = 0;
        for (NSDictionary * dict in subArray) {
            if (j < 3) {
                UIView * subView = [[UIView alloc] initWithFrame:CGRectMake(j*kWidth/3, CNlabel.frame.origin.y+CNlabel.frame.size.height+4, kWidth/3, cellview.frame.size.height/2.5)];
                UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, kWidth/3-30, subView.frame.size.height/3*2)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                [subView addSubview:imgView];
                UILabel * subLabel = [[UILabel alloc] init];
                subLabel.textAlignment = NSTextAlignmentCenter;
                subLabel.bounds = CGRectMake(0, 0, kWidth/3, 20);
                if (kWidth == 375) {
                    [subLabel setFont:[UIFont systemFontOfSize:13]];
                } else if (kWidth == 320) {
                    [subLabel setFont:[UIFont systemFontOfSize:11]];
                } else {
                    [subLabel setFont:[UIFont systemFontOfSize:15]];
                }
                subLabel.center = CGPointMake(subView.frame.size.width/2, imgView.frame.origin.y+imgView.frame.size.height+11);
                subLabel.text = dict[@"title"];
                [subView addSubview:subLabel];
                [cellview addSubview:subView];

                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 300 + 10 * i + j;
                button.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height);
                [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchDown];
                [imgView addSubview:button];
                imgView.userInteractionEnabled = YES;
            }
            if (j >= 3) {
                UIView * subView = [[UIView alloc] initWithFrame:CGRectMake((j-3)*kWidth/3, CNlabel.frame.origin.y+CNlabel.frame.size.height+4+cellview.frame.size.height/2.5, kWidth/3, cellview.frame.size.height/2.5)];
                UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, kWidth/3-30, subView.frame.size.height/3*2)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
                [subView addSubview:imgView];
                UILabel * subLabel = [[UILabel alloc] init];
                subLabel.textAlignment = NSTextAlignmentCenter;
                subLabel.bounds = CGRectMake(0, 0, kWidth/3, 20);
                if (kWidth == 375) {
                    [subLabel setFont:[UIFont systemFontOfSize:13]];
                } else if (kWidth == 320) {
                    [subLabel setFont:[UIFont systemFontOfSize:11]];
                } else {
                    [subLabel setFont:[UIFont systemFontOfSize:15]];
                }
                subLabel.center = CGPointMake(subView.frame.size.width/2, imgView.frame.origin.y+imgView.frame.size.height+11);
                subLabel.text = dict[@"title"];
                [subView addSubview:subLabel];
                [cellview addSubview:subView];

                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 300 + 10 * i + j;
                button.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height);
                [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchDown];
                [imgView addSubview:button];
                imgView.userInteractionEnabled = YES;
            }
            j++;
        }

        UILabel * moreLabel = [[UILabel alloc] init];
        moreLabel.textAlignment = NSTextAlignmentCenter;
        moreLabel.bounds = CGRectMake(0, 0, 100, 30);
        moreLabel.center = CGPointMake(cellview.frame.size.width/2, cellview.frame.origin.y+cellview.frame.size.height-20);
        moreLabel.text = @"更多商品 >";
        moreLabel.layer.cornerRadius = 15;
        moreLabel.layer.masksToBounds = YES;
        moreLabel.backgroundColor = [UIColor redColor];
        [moreLabel setTextColor:[UIColor whiteColor]];
        [cellview addSubview:moreLabel];
        [_TV.bigTopicScroll addSubview:cellview];

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 400 + i;
        button.frame = CGRectMake(0, 0, moreLabel.frame.size.width, moreLabel.frame.size.height);
        [button addTarget:self action:@selector(didClickButton1:) forControlEvents:UIControlEventTouchDown];
        [moreLabel addSubview:button];
        moreLabel.userInteractionEnabled = YES;
        i++;
    }
}
//  更多按钮的点击事件 推出详情
- (void)didClickButton1:(UIButton *)button {
    NSArray * array = _bigDic[@"topic"];
    NSMutableArray * urlArray = [NSMutableArray array];
    for (NSDictionary * dic in array) {
        [urlArray addObject:dic[@"url"]];
    }
    for (int i = 0; i < array.count; i++) {
        if (button.tag == 400 + i) {
            WebViewController * WV = [[WebViewController alloc] init];
            UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
            WV.url = urlArray[i];
            [self presentViewController:NC animated:YES completion:nil];
        }
    }
}
//  子商品列表的点击事件 推出详情
- (void)didClickButton:(UIButton *)button {
    NSMutableArray * urlArray = [NSMutableArray array];
    NSArray * array = _bigDic[@"topic"];
    for (NSDictionary * dic in array) {
        NSArray * subArray = dic[@"subList"];
        for (NSDictionary * dict in subArray) {
            NSString * str = [NSString stringWithFormat:@"http://mall.wv.mtime.cn/#!/commerce/item/%@/", dict[@"goodsId"]];
            [urlArray addObject:str];
        }
    }
    for (int i = 0; i < array.count; i++) {
        for (int j = 0; j < 6; j++) {
            if (button.tag == 300+10*i+j) {
                WebViewController * WV = [[WebViewController alloc] init];
                UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
                WV.url = urlArray[10*i+j-i*4];
                [self presentViewController:NC animated:YES completion:nil];
            }
        }
    }
}
//  更多商品选择按钮的位移事件
- (void)clickButton:(UIButton *)button {
    NSArray * array11 = _bigDic[@"topic"];
    for (int i = 0; i < array11.count; i++) {
        if (button.tag == 100 + i) {
            [_TV.topicScrollView setContentOffset:CGPointMake(i*kWidth, 0) animated:NO];
            [_TV.bigTopicScroll setContentOffset:CGPointMake(i*kWidth, 0) animated:NO];
        }
        if (button.tag == 100 || button.tag == 101) {
            [_TV.smallTopicScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        if (button.tag == 102) {
            [_TV.smallTopicScroll setContentOffset:CGPointMake(kWidth/8, 0) animated:YES];
        }
        if (button.tag == 103 || button.tag == 104) {
            [_TV.smallTopicScroll setContentOffset:CGPointMake(kWidth/4, 0) animated:YES];
        }
    }
}
//  大滚动视图的位移事件 改变导航栏透明度
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_ScrollView.contentOffset.y <= _Navigation.frame.size.height) {
        _Navigation.alpha = _ScrollView.contentOffset.y / _Navigation.frame.size.height;
    } else {
        _Navigation.alpha = 1;
    }
}
//  集合视图item的点击事件 推出详情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WebViewController * WV = [[WebViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:WV];
    ZModel * model = _goodsArray[indexPath.row];
    WV.url = model.url;
    [self presentViewController:NC animated:YES completion:nil];
}

@end
