//
//  LImminentModel.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/23.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LImminentModel : NSObject


#pragma mark ---attention数组中的数据
@property(nonatomic,assign)NSInteger  myId;  // 电影id
@property(nonatomic,strong)NSString * image; // 图片网址
@property(nonatomic,strong)NSString * title; // 标题
@property(nonatomic,strong)NSString * releaseDate; // 上映日期
@property(nonatomic,strong)NSString * type; // 影片类型
@property(nonatomic,strong)NSString * director; // 导演
@property(nonatomic,assign)NSInteger  wantedCount; // 想看的人数
@property(nonatomic,strong)NSArray * videos;  // 预告片数组
@property(nonatomic,assign)NSInteger  rDay;    // 上映的某一天
@property(nonatomic,assign)NSInteger  rMonth;  // 上映的月份
@property(nonatomic,assign)BOOL  isVideo; // 判断是否有预告片
@property(nonatomic,strong)NSString *  actor1; // 演员1
@property(nonatomic,strong)NSString * actor2;  // 演员2
@property(nonatomic,strong)NSString * locationName; // 上映的地区


#pragma mark ---预告片数组中的字典中的数据
@property(nonatomic,strong)NSString * hightUrl; // 预告片网址
//@property(nonatomic,strong)NSString * title;  // 预告片标题

#pragma mark ---moviecomings数组中的数据
// 与attention数组中的数据一致



@end
