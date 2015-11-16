//
//  LCinemaModel.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCinemaModel : NSObject

@property(nonatomic,assign)NSInteger cinemaId; //影院id
@property(nonatomic,strong)NSString * address;// 影院地址
@property(nonatomic,strong)NSString * cinameName;// 影院名字
@property(nonatomic,assign)NSInteger districtID;// 影院所在区的id
@property(nonatomic,assign)NSInteger minPrice; // 最低价格
@property(nonatomic,assign)Float32 ratingFinal; // 影院评分
@property(nonatomic,strong)NSDictionary * feature;// 影院功能
@property(nonatomic,assign)BOOL has3D;   // 是否有3D
@property(nonatomic,assign)BOOL hasPark;
@property(nonatomic,assign)BOOL hasIMAX;

@end
