//
//  FirstTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/28.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieShopModel.h"

@interface FirstTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *todayImgView;

@property (weak, nonatomic) IBOutlet UIImageView *hotImgView;


@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@property(nonatomic, strong)MovieShopModel * model;

@end