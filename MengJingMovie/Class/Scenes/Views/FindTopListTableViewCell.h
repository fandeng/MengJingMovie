//
//  FindTopListTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindTopListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *findTopListNameCn;

@property (weak, nonatomic) IBOutlet UILabel *findTopListsummary;


- (void)fetchdataWithModel:(FindModel *)model;

@end
