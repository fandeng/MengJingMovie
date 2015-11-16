//
//  DetailViewController.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/28.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LImminentModel;
@class LHotModel;


@interface DetailViewController : UIViewController

@property(nonatomic,strong)LImminentModel * LIModel;// 接受上级传过来的电影的model

@property(nonatomic,strong)LHotModel * LHModel; // 热门电影model

@property(nonatomic,assign)BOOL panduan;   // 判断网址

@end
