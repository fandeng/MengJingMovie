//
//  FindModel.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModel : NSObject



@property(nonatomic, assign)NSInteger myId;//电影id
@property(nonatomic, strong)NSString * type;//类型编号
@property(nonatomic, strong)NSString * image;//cell图片
@property(nonatomic, assign)NSInteger publishTime;//上传时间
@property(nonatomic, assign)NSInteger  commentCount;//评论次数
@property(nonatomic, strong)NSString * title;//名字
@property(nonatomic, strong)NSString * title2;//重命名
@property(nonatomic, strong)NSString * imageUrl;//图片网址
@property(nonatomic, strong)NSString * hightUrl;//视频网址

@property(nonatomic, strong)NSString * movieName;//预告片  电影名字
@property(nonatomic, strong)NSString * summary;//预告片  电影摘要
@property(nonatomic, strong)NSString * coverImg;//预告片 电影图片


@property(nonatomic, strong)NSString * topListNameCn;//


@property(nonatomic, strong)NSString * nickname;
@property(nonatomic, strong)NSString * userImage;
@property(nonatomic, strong)NSString * rating;
@property(nonatomic, strong)NSDictionary * relatedObj;


@property(nonatomic, strong)NSString * nameCn;
@property(nonatomic, strong)NSString * nameEn;
@property(nonatomic, assign)NSInteger rankNum;
@property(nonatomic, strong)NSString * sex;
@property(nonatomic, strong)NSString * birthDay;
@property(nonatomic, strong)NSString * birthLocation;
@property(nonatomic, strong)NSString * posterUrl;
@property(nonatomic, strong)NSString * name;
@property(nonatomic, strong)NSString * director;
@property(nonatomic, strong)NSString * actor;
@property(nonatomic, strong)NSString * releaseDate;//上映时间
@property(nonatomic, strong)NSString * remark;

@property(nonatomic, assign)NSInteger totalCount;//详情界面数据个数

@property(nonatomic, strong)NSString * weekBoxOffice;
@property(nonatomic, strong)NSString * totalBoxOffice;



@end
