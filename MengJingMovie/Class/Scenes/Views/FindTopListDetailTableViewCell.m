//
//  FindTopListDetailTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright © 2015年 mengjing. All rights reserved.
//

#import "FindTopListDetailTableViewCell.h"

@implementation FindTopListDetailTableViewCell

- (void)fetchdataWithModel:(FindModel *)model {
    
    
    self.findDetailName.text = model.nameCn;
    self.findDetailName2.text = model.nameEn;
   // self.findDetailRating.text = model.rating;
    self.findDetailTopList.text = [NSString stringWithFormat:@"%ld",(long)model.rankNum];
    self.findDetailMoney.text = model.summary;
    self.findDetailIntroduce.text = [NSString stringWithFormat:@"%@,%@,(%@)",model.sex,model.birthDay,model.birthLocation];
    [self.findDetailImageView sd_setImageWithURL:[NSURL URLWithString:model.posterUrl]];
    
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
