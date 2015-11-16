//
//  FindNewsDetailTopTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/27.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FindNewsDetailTopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *findNewsNumber;

@property (weak, nonatomic) IBOutlet UIImageView *findNewsImages;

@property (weak, nonatomic) IBOutlet UILabel *fingNewsNames;

@property (weak, nonatomic) IBOutlet UILabel *findNewsName2;

@property (weak, nonatomic) IBOutlet UILabel *findNewsDir;

@property (weak, nonatomic) IBOutlet UILabel *findNewsActor;
@property (weak, nonatomic) IBOutlet UILabel *findNewsLoca;
@property (weak, nonatomic) IBOutlet UILabel *findNewsTotalBoxOffice;


- (void)fetchdataWithModel:(FindModel *)model;

@end
