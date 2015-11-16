//
//  ShareRequestData.h
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@class ShareRequestData;
@protocol shareRequestDataDelegate <NSObject>

@optional//可选实现
//请求网络数据，将Data传到控制器
- (void)shareRequestHandle:(ShareRequestData *)requestHandle data:(NSData *)data;
@end

@protocol shareRequestDataDateSource <NSObject>

//数据请求成功，将data传到控制器
- (void)shareRequestData:(ShareRequestData *)requestHandle didSucceedWithData:(NSData *)data;

@end

@interface ShareRequestData : NSObject

//创建单例类
+ (instancetype)sharedManager;

@property(nonatomic, weak)id<shareRequestDataDelegate> delegate;

@property(nonatomic, weak)id<shareRequestDataDateSource> datesource;

@property(nonatomic, strong)MBProgressHUD * hud;//第三方类

@property(nonatomic, strong)NSString * city;//存放城市


#pragma mark ---加载效果
- (void)loadProgress:(UIView *)view;

//隐藏加载
- (void)opinionHide:(BOOL)opinion;

//自定义初始化方法(根据传入的网址解析数据Data)
- (instancetype)initWithUrlByString:(NSString *)urlString;
//显示提示框
- (void)showAlertViewWithMessage:(NSString *)messageString number:(NSInteger)num;
@end