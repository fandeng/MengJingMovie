//
//  FinftopListDetailMovieTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright © 2015年 mengjing. All rights reserved.
//

#import "FinftopListDetailMovieTableViewCell.h"

@implementation FinftopListDetailMovieTableViewCell

- (void)fetchdataWithModel:(FindModel *)model {
    
    
    self.findDetailname.text = model.name;
    self.findDetailName2.text = model.nameEn;
    // self.findDetailRating.text = model.rating;
    self.findDetailNum.text = [NSString stringWithFormat:@"%ld",(long)model.rankNum];
    self.finddetailRemark.text = model.remark;
    self.fingDetaolDirector.text = [NSString stringWithFormat:@"导演:%@",model.director];
    self.findDetailActor.text = [NSString stringWithFormat:@"主演:%@",model.actor];
    self.findDetailDate.text = [NSString stringWithFormat:@"上映日期:%@",model.releaseDate];
    [self.fingDetailImageView sd_setImageWithURL:[NSURL URLWithString:model.posterUrl]];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
