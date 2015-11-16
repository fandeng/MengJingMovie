//
//  FMovieDetailsCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FMovieDetailsCell.h"

@implementation FMovieDetailsCell


- (void)setCmodel:(CommentsModel *)cmodel
{
    [self.photoImgView sd_setImageWithURL:[NSURL URLWithString:cmodel.caimg]];
    
    self.nameLable.text = cmodel.ca;
    
    //评分
    if (cmodel.cr == -1) {
        self.ratingLabel.hidden = YES;
    } else {
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",cmodel.cr];
    }
    //时间戳转换为时间
    NSString *str= [NSString stringWithFormat:@"%ld",cmodel.lcd];//时间戳
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];//转为对应的时间
    //判断是刚刚还是几分钟前或几小时前
    if ([detaildate timeIntervalSinceNow] < 60 && [detaildate timeIntervalSinceNow] >= 0) {
        
        self.timeLabel.text = @"刚刚";
        
    } else if (60 < [detaildate timeIntervalSinceNow] && [detaildate timeIntervalSinceNow] < 3600){
        
        self.timeLabel.text = [NSString stringWithFormat:@"%.f分钟前",[detaildate timeIntervalSinceNow] / 60];
        
    } else if ([detaildate timeIntervalSinceNow] < 0){
        
        self.timeLabel.text = @"24小时前";
        
    } else {
        self.timeLabel.text  = [NSString stringWithFormat:@"%.f小时前",[detaildate timeIntervalSinceNow] / 3600];
    }
    self.commentsLabel.text = cmodel.ce;
    
    [self.contentView layoutIfNeeded];//提前适配
    
    CGFloat height = [[self class] getTextHeight:cmodel.ce];
    CGRect frame = _commentsLabel.frame;
    frame.size.height  = height;
    _commentsLabel.frame = frame;
}

+ (CGFloat)getTextHeight:(NSString *)text
{
    CGSize size = CGSizeMake(290, 20000);
    
    UIFont * font = [UIFont systemFontOfSize:17.0];
    
    NSDictionary * dic = @{NSFontAttributeName:font};
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:NULL];
    
    return rect.size.height;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
