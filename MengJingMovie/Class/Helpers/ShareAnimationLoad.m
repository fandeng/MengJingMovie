//
//  ShareAnimationLoad.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/30.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "ShareAnimationLoad.h"

@implementation ShareAnimationLoad

+ (instancetype)ShareAnimation
{
    static ShareAnimationLoad * shareAnimationLoad = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareAnimationLoad = [[ShareAnimationLoad alloc] init];
    });
    return shareAnimationLoad;
}


//正在加载
- (void)animationingLoad:(UIView *)view{
    
    self.indicator = [[YYAnimationIndicator alloc]initWithFrame:CGRectMake(view.frame.size.width/2-40, view.frame.size.height/2-40, 80, 80)];
    [_indicator setLoadText:@"正在加载..."];
    [view addSubview:_indicator];
    [_indicator startAnimation];  //开始转动
}
//加载成功
- (void)animationSuccessLoad{
    
    [_indicator stopAnimationWithLoadText:@"finish" withType:YES];//加载成功
}
//加载失败
- (void)animationFailLoad{
    
    [_indicator stopAnimationWithLoadText:@"加载失败" withType:NO];//加载失败
}

@end
