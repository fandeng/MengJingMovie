//
//  FindreviewTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindreviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *findReviewTitle;

@property (weak, nonatomic) IBOutlet UILabel *findReviewSummary;

@property (weak, nonatomic) IBOutlet UILabel *findReviewNickName;
@property (weak, nonatomic) IBOutlet UILabel *findReviewRating;
@property (weak, nonatomic) IBOutlet UIImageView *findReviewImageView;


- (void)fetchdataWithModel:(FindModel *)model;

@end
