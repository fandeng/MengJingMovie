//
//  HomepageUrls.h
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#ifndef Homepage_MengJingMovies_HomepageUrls_h
#define Homepage_MengJingMovies_HomepageUrls_h

//电影网址
#define kMoviesUrl(cityId)  [NSString stringWithFormat:@"http://api.m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=%ld",cityId]

//城市网址
#define kCityUrl @"http://api.m.mtime.cn/Showtime/HotCitiesByCinema.api"

//商品、今日特惠、今日热点
#define kShopHotUrl @"http://api.m.mtime.cn/PageSubArea/GetFirstPageAdvAndNews.api"

//电影详情界面评论
#define kCommentsUrl(movieId,index) [NSString stringWithFormat:@"http://api.m.mtime.cn/Showtime/MovieComments.api?movieId=%ld&pageIndex=%ld",movieId,index]



#endif
