//
//  CinemaTableViewCell.h
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCinemaModel;

@interface LCinemaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cinemaIdLabel; // 影院名称
@property (weak, nonatomic) IBOutlet UILabel *adderssLabel;  // 地址
@property (weak, nonatomic) IBOutlet UILabel *minPriceLabel; // 价格
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel; // 距离


@property(nonatomic,strong)LCinemaModel * cinemamodel;


@end
