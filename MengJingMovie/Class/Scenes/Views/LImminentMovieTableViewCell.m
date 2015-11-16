//
//  ImminentMovieTableViewCell.m
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import "LImminentMovieTableViewCell.h"
#import "LImminentModel.h"
#import "LImminentMovieTableViewController.h"
#import "PrevueViewController.h"




@implementation LImminentMovieTableViewCell

- (void)awakeFromNib {
    
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)setImminentModel:(LImminentModel *)imminentModel
{
    if (_imminentModel != imminentModel) {
        _imminentModel = imminentModel;
    }
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imminentModel.image]];
    self.titleLabel.text = imminentModel.title;
    self.dayLabel.text = [NSString stringWithFormat:@"%ld日",imminentModel.rDay];
    self.typeLabel.text = imminentModel.type;
    self.actorLabel.text = imminentModel.director;
    self.peopleLabel.text = [NSString stringWithFormat:@"%ld",imminentModel.wantedCount];
    
    if (imminentModel.isVideo == 0) {
        // 当没有预告片时让图标消失
        self.prevueView.hidden = YES;
        }else{
        // 当有预告片时就让图标出现
        self.prevueView.hidden = NO;
    }
}


- (IBAction)didImageAction:(id)sender {
    
    
    
}
@end
