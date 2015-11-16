//
//  HotModel.h
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHotModel : NSObject

@property(nonatomic,assign)NSInteger movieId; // 电影ID
@property(nonatomic,strong)NSString * titleCn; // 影片名字
@property(nonatomic,strong)NSString * titleEn; // 影片副标题
@property(nonatomic,strong)NSString * type; // 电影类型
@property(nonatomic,strong)NSString * img;  // 图片网址
@property(nonatomic,strong)NSString * commonSpecial; // 副标题
@property(nonatomic,assign)NSInteger rMonth; // 上映的月份
@property(nonatomic,assign)NSInteger rDay;  // 上映的那天
@property(nonatomic,assign)Float32 ratingFinal;  // 评分
@property(nonatomic,assign)NSInteger wantedCount; // 想看的人数
@property(nonatomic,strong)NSString * directorName; // 导演
@property(nonatomic,strong)NSString * actorName1;  // 演员1
@property(nonatomic,strong)NSString * actorName2; // 演员2

@property(nonatomic,retain)NSDictionary * nearestShowtime; // 字典
// movies数组中的 0 字典中的 nearestShowtime数组中的数据
//@property(nonatomic,assign)NSInteger nearestCinemaCount; // 影院数量
//@property(nonatomic,assign)NSInteger nearestShowtimeCount; // 上映的场数

@end
