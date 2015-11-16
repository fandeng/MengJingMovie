//
//  FindreviewTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FindreviewTableViewCell.h"

@implementation FindreviewTableViewCell


- (void)fetchdataWithModel:(FindModel *)model {
    
    self.findReviewTitle.text = model.title;
    
    NSString * temp = @"";
    NSRange rang = [model.summary rangeOfString:@"\n\r\n"];
    
    if (rang.length == 0) {
        
         temp = model.summary;
    } else {
        
        temp = [model.summary stringByReplacingOccurrencesOfString:@"\n\r\n" withString:@""];
    }
    
    NSRange rang1 = [temp rangeOfString:@"\n"];
    
    if (rang1.length == 0) {
        
        self.findReviewSummary.text = temp;
    } else {
        
        self.findReviewSummary.text = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
 
    
    [self.findReviewImageView sd_setImageWithURL:[NSURL URLWithString:model.relatedObj[@"image"]]];
    self.findReviewNickName.text = model.nickname;
    self.findReviewRating.text = model.rating;
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
