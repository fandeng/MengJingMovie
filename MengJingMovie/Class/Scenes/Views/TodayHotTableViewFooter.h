//
//  TodayHotTableViewFooter.h
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol todayHotTableViewFooterDelegate <NSObject>

- (void)changeViewWithAction;

@end

@interface TodayHotTableViewFooter : UIView

@property (weak, nonatomic) IBOutlet UIImageView *filmImgView;//图片

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题

@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;//介绍

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//电影名字

@property (weak, nonatomic) IBOutlet UIImageView *imgView;//电影图片

@property(nonatomic, weak)id<todayHotTableViewFooterDelegate> fdelegate;

@end