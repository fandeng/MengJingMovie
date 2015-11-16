//
//  ShareAnimationLoad.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/30.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YYAnimationIndicator.h"

@interface ShareAnimationLoad : NSObject

+ (instancetype)ShareAnimation;

@property(nonatomic, strong) YYAnimationIndicator *indicator;


//正在加载
- (void)animationingLoad:(UIView *)view;;
//加载成功
- (void)animationSuccessLoad;
//加载失败
- (void)animationFailLoad;

@end
