//
//  FindTopListDetailTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright © 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindTopListDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *findDetailTopList;
@property (weak, nonatomic) IBOutlet UIImageView *findDetailImageView;
@property (weak, nonatomic) IBOutlet UILabel *findDetailName;
@property (weak, nonatomic) IBOutlet UILabel *findDetailRating;
@property (weak, nonatomic) IBOutlet UILabel *findDetailName2;
@property (weak, nonatomic) IBOutlet UILabel *findDetailIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *findDetailMoney;


- (void)fetchdataWithModel:(FindModel *)model;

@end
