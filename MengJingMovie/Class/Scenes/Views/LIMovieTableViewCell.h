//
//  LIMovieTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/29.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDetailModel;

@interface LIMovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *NameimgView;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property(nonatomic,strong)LDetailModel * detailModel;

// 计算内容文本高度
+ (CGFloat)computerHeightWithText:(NSString *)text Width:(CGFloat)width;
@end
