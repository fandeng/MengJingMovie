//
//  LIMovieDetail.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/29.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIMovieDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *MovieImgView;  // 图片
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;  // 影片名字
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;  // 评分
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;   // 类型
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;  // 日期
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;  // 想看人数
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;  // 导演
@property (weak, nonatomic) IBOutlet UILabel *actor1Label; // 主演1
@property (weak, nonatomic) IBOutlet UILabel *actor2Label;  // 主演2



@end
