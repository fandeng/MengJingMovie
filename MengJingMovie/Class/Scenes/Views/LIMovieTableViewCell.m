//
//  LIMovieTableViewCell.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/29.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "LIMovieTableViewCell.h"
#import "LDetailModel.h"

@implementation LIMovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailModel:(LDetailModel *)detailModel
{
    NSString  * str  = [NSString stringWithFormat:@"%ld",detailModel.cr];
    if (str == nil) {
        NSLog(@"评分为空");
    }

    [self.NameimgView sd_setImageWithURL:[NSURL URLWithString:detailModel.caimg]];
    self.NameLabel.text = detailModel.ca;
    self.ratingLabel.text = [NSString stringWithFormat:@"评分:%ld",detailModel.cr];
    // 时间戳转为时间
    NSString * strs = [NSString stringWithFormat:@"%ld",detailModel.lcd];
    NSTimeInterval time = [strs doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString * current = [formatter stringFromDate:date];
        
    
    self.timeLabel.text = current;
    self.contentLabel.text = detailModel.ce;
    
}
// 根据传过来的评论内容和版本的frame计算高度
+ (CGFloat)computerHeightWithText:(NSString *)text Width:(CGFloat)width
{
    CGSize size = CGSizeMake(width-218, 20000);
    UIFont * font = [UIFont systemFontOfSize:12.0];
    NSDictionary * dic = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}


@end
