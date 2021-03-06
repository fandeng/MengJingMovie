//
//  MovieShopModel.h
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieShopModel : NSObject

@property(nonatomic, strong)NSArray * advList;//轮播图片数组

@property(nonatomic, strong)NSArray * hotPoints;//热点数组

@property(nonatomic, strong)NSDictionary * hotMovie;//每日佳品字典

@property(nonatomic, strong)NSDictionary * areaSecond;//新品，每日特惠商品

#pragma mark ------advList数组中字典的元素
@property(nonatomic, strong)NSString * url;//详情网址
@property(nonatomic, strong)NSString * img;//图片网址

#pragma mark ------hotPoints数组中字典元素

@property(nonatomic, strong)NSString * title;//标题

@property(nonatomic, assign)NSInteger hotId;//热点id

@property(nonatomic, strong)NSString * desc;//描述

@property(nonatomic, strong)NSArray * images;//图片网址数组

@property(nonatomic, assign)NSInteger publishTime;//时间戳

@property(nonatomic, strong)NSString * url1;//图片网址




@end
