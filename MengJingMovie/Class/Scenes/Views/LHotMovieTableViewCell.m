//
//  HotMovieTableViewCell.m
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import "LHotMovieTableViewCell.h"
#import "LHotModel.h"
#import "UIImageView+WebCache.h"

@implementation LHotMovieTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (void)setHotmodel:(LHotModel *)hotmodel
{
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:hotmodel.img]];
    self.titleLabel.text = hotmodel.titleCn;
    self.secondLabel.text = hotmodel.commonSpecial;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",hotmodel.ratingFinal]; // 评分
    self.monthLabel.text = [NSString stringWithFormat:@"%ld",hotmodel.rMonth];
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",hotmodel.rDay];
    self.cinemaCountLabel.text = [NSString stringWithFormat:@"%@",hotmodel.nearestShowtime[@"nearestCinemaCount"]];
    self.showtimeCountLabel.text = [NSString stringWithFormat:@"%@",hotmodel.nearestShowtime[@"nearestShowtimeCount"]];

}


@end
