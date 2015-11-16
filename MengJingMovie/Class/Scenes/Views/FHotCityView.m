//
//  FHotCityView.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "FHotCityView.h"

@implementation FHotCityView

//上海
- (IBAction)shanghaiAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithShanghaiAction)]) {
        
        [_delegate fHotCityViewWithShanghaiAction];
    }
}
//北京
- (IBAction)bjAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithBJAction)]) {
        
        [_delegate fHotCityViewWithBJAction];
    }
}
//广州
- (IBAction)guangzhouAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithGuangzhouAction)]) {
        
        [_delegate fHotCityViewWithGuangzhouAction];
    }
}
//深圳
- (IBAction)shenzhenAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithShenzhenAction)]) {
        
        [_delegate fHotCityViewWithShenzhenAction];
    }
}
//杭州
- (IBAction)hangzhouAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithHangzhouAction)]) {
        
        [_delegate fHotCityViewWithHangzhouAction];
    }
}
//武汉
- (IBAction)wuhanAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithWuhanAction)]) {
        
        [_delegate fHotCityViewWithWuhanAction];
    }
}
//重庆
- (IBAction)chongqingAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithChongqingAction)]) {
        
        [_delegate fHotCityViewWithChongqingAction];
    }
}
//成都
- (IBAction)chengduAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithChengduAction)]) {
        
        [_delegate fHotCityViewWithChengduAction];
    }
}
//天津
- (IBAction)tianjianAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fHotCityViewWithTianjinAction)]) {
        
        [_delegate fHotCityViewWithTianjinAction];
    }
}





@end
