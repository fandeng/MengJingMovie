//
//  FindNewsOneTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FindNewsOneTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *findImageView;//图片

@property (weak, nonatomic) IBOutlet UILabel *findTitle;//标题

@property (weak, nonatomic) IBOutlet UILabel *findTitle2;//副标题

@property (weak, nonatomic) IBOutlet UILabel *findTime;//上传时间

@property (weak, nonatomic) IBOutlet UILabel *findCount;//评论次数

- (void)fetchdataWithModel:(FindModel *)model;

@end
