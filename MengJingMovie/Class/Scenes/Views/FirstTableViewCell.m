//
//  FirstTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/28.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FirstTableViewCell.h"


@implementation FirstTableViewCell

- (void)setModel:(MovieShopModel *)model
{
    [self.todayImgView sd_setImageWithURL:[NSURL URLWithString:model.areaSecond[@"subFirst"][@"image2"]]];
    [self.hotImgView sd_setImageWithURL:[NSURL URLWithString:model.areaSecond[@"subSecond"][@"image2"]]];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.areaSecond[@"subThird"][@"image"]]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
