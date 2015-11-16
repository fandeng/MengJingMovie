//
//  LDetailModel.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/28.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDetailModel : NSObject

@property(nonatomic,assign)NSInteger totalCount; // 评论数
@property(nonatomic,strong)NSString * ce; // 评论内容
@property(nonatomic,strong)NSString * caimg; // 网友头像网址
@property(nonatomic,strong)NSString * ca; // 网友名字
@property(nonatomic,strong)NSString * title; // 评论标题
@property(nonatomic,assign)NSInteger cr; // 评分
@property(nonatomic,assign)NSInteger lcd; //多久前评论的，时间戳

@end
