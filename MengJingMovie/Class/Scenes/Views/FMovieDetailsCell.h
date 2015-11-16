//
//  FMovieDetailsCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsModel.h"

@interface FMovieDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLable;//昵称
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;//评分

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;//评论

@property(nonatomic, strong)CommentsModel * cmodel;

+ (CGFloat)getTextHeight:(NSString *)text;

@end
