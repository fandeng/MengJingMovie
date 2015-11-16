//
//  Urls.h
//  MovieTime2
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 李超男. All rights reserved.
//

#ifndef MovieTime2_Urls_h
#define MovieTime2_Urls_h
// 电影-》正在热映
#define  kHotUrl @"http://api.m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=290"
// 电影-》即将上映
#define kImminentUrl @"http://api.m.mtime.cn/Movie/MovieComingNew.api?locationId=290"

// 电影详情页面里的评论 精彩评论
#define kMovieReview(myId,page) [NSString stringWithFormat:@"http://api.m.mtime.cn/Movie/HotLongComments.api?movieId=%ld&pageIndex=%d",myId,page]
// 网友短评
#define kMovieReviews(myId,page) [NSString stringWithFormat:@"http://api.m.mtime.cn/Showtime/MovieComments.api?movieId=%ld&pageIndex=%ld",myId,page]


// 影院列表图片
#define kCinemaPicUrl @"http://static1.mtime.cn/feature/mobile/item/2015/banner/1017/750175.html"
// 影院列表
#define kCinemaUrl @"http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api?locationId=290&deviceToken=%7B1%7D"

#endif
