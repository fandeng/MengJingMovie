//
//  TodayHotTableViewFooter.m
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "TodayHotTableViewFooter.h"

@implementation TodayHotTableViewFooter

//新闻事件
- (IBAction)newsAction:(id)sender {
    
    if ([self.fdelegate respondsToSelector:@selector(changeViewWithAction)]) {
        
        [_fdelegate changeViewWithAction];
    }
}
//预告片事件
- (IBAction)prevueAction:(id)sender {
    if ([self.fdelegate respondsToSelector:@selector(changeViewWithAction)]) {
        
        [_fdelegate changeViewWithAction];
    }
}
//排行榜事件
- (IBAction)topAction:(id)sender {
    if ([self.fdelegate respondsToSelector:@selector(changeViewWithAction)]) {
        
        [_fdelegate changeViewWithAction];
    }
}
//影评
- (IBAction)filmAction:(id)sender {
    if ([self.fdelegate respondsToSelector:@selector(changeViewWithAction)]) {
        
        [_fdelegate changeViewWithAction];
    }
}
//更多推荐
- (IBAction)recommendedAction:(id)sender {
    if ([self.fdelegate respondsToSelector:@selector(changeViewWithAction)]) {
        
        [_fdelegate changeViewWithAction];
    }
}











@end
