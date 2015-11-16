//
//  FHotCityView.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol fHotCityViewDelegate <NSObject>

@optional//可选实现
- (void)fHotCityViewWithShanghaiAction;//上海
- (void)fHotCityViewWithBJAction;//北京
- (void)fHotCityViewWithGuangzhouAction;//广州
- (void)fHotCityViewWithShenzhenAction;//深圳
- (void)fHotCityViewWithHangzhouAction;//杭州
- (void)fHotCityViewWithWuhanAction;//武汉
- (void)fHotCityViewWithChongqingAction;//重庆
- (void)fHotCityViewWithChengduAction;//成都
- (void)fHotCityViewWithTianjinAction;//天津

@end

@interface FHotCityView : UIView

@property (weak, nonatomic) IBOutlet UILabel *currentCityLable;//当前城市

@property(nonatomic, weak)id<fHotCityViewDelegate> delegate;

@end
