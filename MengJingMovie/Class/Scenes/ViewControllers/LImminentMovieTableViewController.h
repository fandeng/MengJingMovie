//
//  ImminentMovieTableViewController.h
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LImminentMovieTableViewController : UITableViewController


@property(nonatomic,strong)NSMutableArray * monthArray; // 存放月份的数组
@property(nonatomic,strong)NSMutableArray * comingMovieArray; // 存放即将放映的电影model



@end
