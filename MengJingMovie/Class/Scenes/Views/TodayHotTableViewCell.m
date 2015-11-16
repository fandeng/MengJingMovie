//
//  TodayHotTableViewCell.m
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "TodayHotTableViewCell.h"

@implementation TodayHotTableViewCell


- (void)setModel:(MovieShopModel *)model
{
    self.currentArray = [NSMutableArray array];
    for (NSDictionary * dic in model.images) {
        
        MovieShopModel * model = [MovieShopModel new];
        
        [model setValuesForKeysWithDictionary:dic];
        
        [_currentArray addObject:model.url1];
    }
    if (_currentArray.count == 0) {
        self.firstImgView.hidden = YES;
        self.secondImgView.hidden = YES;
        self.thirdImgView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.subtitleLabel.hidden = YES;
        self.timeLable.hidden = YES;
        [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
        self.titileLabel1.text = model.title;
        self.subtitleLabel1.text = model.desc;
        self.timeLabel1.text = [self opinionTimeWith:model.publishTime];
        
    } else {
        self.twoImageView.hidden = YES;
        self.titileLabel1.hidden = YES;
        self.subtitleLabel1.hidden = YES;
        self.timeLabel1.hidden = YES;
        
        self.titleLabel.text = model.title;
        self.subtitleLabel.text = model.desc;
        [self.firstImgView sd_setImageWithURL:[NSURL URLWithString:_currentArray[0]] placeholderImage:nil];
        [self.secondImgView sd_setImageWithURL:[NSURL URLWithString:_currentArray[1]] placeholderImage:nil];
        [self.thirdImgView sd_setImageWithURL:[NSURL URLWithString:_currentArray[2]] placeholderImage:nil];
        self.timeLable.text = [self opinionTimeWith:model.publishTime];
    }
}

- (NSString *)opinionTimeWith:(NSInteger)timeNumber
{
    //时间戳转换为时间
    NSString *str= [NSString stringWithFormat:@"%ld",timeNumber];//时间戳
    
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];//获取和当前时间的时差
    //判断是刚刚还是几分钟前或几小时前
    if ([detaildate timeIntervalSinceNow] < 60) {
        
        return @"刚刚";
        
    } else if (60 < [detaildate timeIntervalSinceNow] && [detaildate timeIntervalSinceNow] < 3600){
        
        return [NSString stringWithFormat:@"%.f分钟前",[detaildate timeIntervalSinceNow] / 60];
        
    } else {
        return [NSString stringWithFormat:@"%.f小时前",[detaildate timeIntervalSinceNow] / 3600];
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
