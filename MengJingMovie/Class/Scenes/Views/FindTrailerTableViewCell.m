//
//  FindTrailerTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FindTrailerTableViewCell.h"


@implementation FindTrailerTableViewCell


- (void)fetchdataWithModel:(FindModel *)model{
    
    self.findTrailermovieName.text = model.movieName;
    self.findTrailerSummary.text = model.summary;
    [self.findImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg]];
  
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
