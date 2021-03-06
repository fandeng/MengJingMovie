//
//  WUrl.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/29.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#ifndef MengJingMovie_WUrl_h
#define MengJingMovie_WUrl_h

//Find首页图片
#define KFindimage @"http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api"
//FindNews

#define kFindNews(count) [NSString stringWithFormat: @"http://api.m.mtime.cn/News/NewsList.api?pageIndex=%ld",count]


#define kFindNewsDetail(myId) [NSString stringWithFormat:@"http://api.m.mtime.cn/News/Detail.api?newsId=%ld",myId]

#define kCNTicket @"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=2020"

#define kGlobelTicket(columnId) [NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=%@",columnId]

//FindTrailer

#define kFindTrailer [NSString stringWithFormat:@"http://api.m.mtime.cn/PageSubArea/TrailerList.api"]


//FindTopList

#define kFindTopList(count) [NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListOfAll.api?pageIndex=%ld",count]

#define kFindTopListDetail(count,myID)  [NSString stringWithFormat:@"http://api.m.mtime.cn/TopList/TopListDetails.api?pageIndex=%ld&topListId=%ld",count,myID]


//FindReview

#define kFindReview [NSString stringWithFormat:@"http://api.m.mtime.cn/MobileMovie/Review.api?needTop=false"]

#define kFindReviewDetail(myId) [NSString stringWithFormat:@"http://api.m.mtime.cn/Review/Detail.api?reviewId=%ld",myId]

#endif
