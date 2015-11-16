//
//  CommentsModel.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsModel : NSObject

@property(nonatomic, assign)NSInteger lcd;//时间戳

@property(nonatomic, strong)NSString * caimg;//头像网址

@property(nonatomic, assign)NSInteger totalCount;//评论个数

@property(nonatomic, strong)NSString * ca;//用户名

@property(nonatomic, strong)NSString * ce;//评论

@property(nonatomic, assign)float cr;//评分

@end
