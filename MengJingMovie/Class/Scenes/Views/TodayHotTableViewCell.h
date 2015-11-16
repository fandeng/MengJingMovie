//
//  TodayHotTableViewCell.h
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieShopModel.h"

@interface TodayHotTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;//副标题

@property (weak, nonatomic) IBOutlet UIImageView *firstImgView;//图片1

@property (weak, nonatomic) IBOutlet UIImageView *secondImgView;//图片2

@property (weak, nonatomic) IBOutlet UIImageView *thirdImgView;//图片3

@property (weak, nonatomic) IBOutlet UILabel *timeLable;//时间

@property(nonatomic, strong)MovieShopModel * model;//model对象

@property(nonatomic, strong)NSMutableArray * currentArray;//临时数组,存放图片

#pragma mark ---一张图片的格式
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;//图片

@property (weak, nonatomic) IBOutlet UILabel *titileLabel1;//标题

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel1;//副标题

@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;//时间


@end
