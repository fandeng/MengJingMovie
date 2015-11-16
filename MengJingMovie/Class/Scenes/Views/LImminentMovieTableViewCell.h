//
//  ImminentMovieTableViewCell.h
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class LImminentModel;

@interface LImminentMovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *prevueView; // 预告片图标


@property(nonatomic,strong)LImminentModel * imminentModel;

@property(nonatomic,assign)BOOL Path;

//@property(nonatomic,strong)NSArray * secondComingArray;

@property(nonatomic,strong)MPMoviePlayerViewController * player;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage;

- (IBAction)didImageAction:(id)sender;



@end
