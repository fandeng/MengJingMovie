//
//  FindNewsDetailTopTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/27.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FindNewsDetailTopTableViewCell.h"

@implementation FindNewsDetailTopTableViewCell

- (void)fetchdataWithModel:(FindModel *)model {
    
    self.fingNewsNames.text = model.name;
    self.findNewsName2.text = model.nameEn;
    self.findNewsNumber.text = [NSString stringWithFormat:@"%ld",(long)model.rankNum];
    self.findNewsDir.text = [NSString stringWithFormat:@"导演:%@",model.director];
    self.findNewsActor.text = [NSString stringWithFormat:@"主演:%@",model.actor];
    self.findNewsLoca.text = [NSString stringWithFormat:@"上映日期:%@",model.releaseDate];
    
    
    NSString * temp = @"";
    NSString * temp1 = @"";
    NSRange rang = [model.weekBoxOffice rangeOfString:@"\n"];
    
    if (rang.length == 0) {
        
          self.findNewsTotalBoxOffice.text = [NSString stringWithFormat:@"%@万元 %@万元",model.weekBoxOffice,model.totalBoxOffice];
    } else {
        
        temp = [model.weekBoxOffice stringByReplacingOccurrencesOfString:@"\n" withString:@":"];
        temp1 = [model.totalBoxOffice stringByReplacingOccurrencesOfString:@"\n" withString:@":"];
        self.findNewsTotalBoxOffice.text = [NSString stringWithFormat:@"%@万元   %@万元",temp,temp1];
    }
  
    [self.findNewsImages sd_setImageWithURL:[NSURL URLWithString:model.posterUrl]];
    
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
