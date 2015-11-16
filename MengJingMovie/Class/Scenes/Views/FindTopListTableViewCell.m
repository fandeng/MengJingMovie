//
//  FindTopListTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FindTopListTableViewCell.h"

@implementation FindTopListTableViewCell

- (void)fetchdataWithModel:(FindModel *)model{
    
    
    self.findTopListNameCn.text = model.topListNameCn;
    self.findTopListsummary.text = model.summary;
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