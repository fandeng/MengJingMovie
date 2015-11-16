//
//  MoviesModel.h
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviesModel : NSObject

#pragma mark ----top轮播图属性
@property(nonatomic, assign)NSInteger movieId;//电影id

@property(nonatomic, strong)NSString * titleCn;//电影名字

@property(nonatomic, strong)NSString * titleEn;//英文名字

@property(nonatomic, strong)NSString * img;//电影图片

@property(nonatomic, assign)float  ratingFinal;//评分

@property(nonatomic, assign)NSInteger  length;//时长

@property(nonatomic, strong)NSString * type;//电影类型

@property(nonatomic, strong)NSString * commonSpecial;//副标题

@property(nonatomic, assign)NSInteger  rYear;//年份

@property(nonatomic, assign)NSInteger rMonth;//月份

@property(nonatomic, assign)NSInteger  rDay;//日

@property(nonatomic, assign)BOOL is3D;//是否是3D

@property(nonatomic, assign)BOOL  isIMAX3D;//是否是3D大屏

@property(nonatomic, strong)NSString * directorName;//导演

@property(nonatomic, strong)NSString * actorName1;

@property(nonatomic, strong)NSString * actorName2;//演员

@end
