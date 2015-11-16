//
//  FindNewsTwoTableViewCell.m
//  MengJingMovie
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FindNewsTwoTableViewCell.h"

#import "FindModel.h"

#import "UIImageView+WebCache.h"

@implementation FindNewsTwoTableViewCell


- (void)fetchdataWithModel:(FindModel *)model {
    
    self.findTwoTitle.text = model.title;
    self.findTwoTitles.text = model.title2;
    [self.findTwoImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.findTwoTime.text = [NSString stringWithFormat:@"%ld",model.publishTime];
    self.findTwoCount.text = [NSString stringWithFormat:@"%ld",model.commentCount];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
