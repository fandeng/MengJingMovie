//
//  FindTrailerTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindTrailerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *findImageView;//图片

@property (weak, nonatomic) IBOutlet UILabel *findTrailermovieName;//电影名字

@property (weak, nonatomic) IBOutlet UILabel *findTrailerSummary;//电影摘要

- (void)fetchdataWithModel:(FindModel *)model;


@end
