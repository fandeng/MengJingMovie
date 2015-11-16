//
//  MovieShopTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/28.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "MovieShopTableViewCell.h"

@implementation MovieShopTableViewCell


- (IBAction)allShopAction:(id)sender {
    if ([self.msDelegate respondsToSelector:@selector(movieShopTableViewCellChangeViewWithAction)]) {
        
        [_msDelegate movieShopTableViewCellChangeViewWithAction];
    }
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
