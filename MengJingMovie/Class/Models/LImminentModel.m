//
//  LImminentModel.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/23.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "LImminentModel.h"

@implementation LImminentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.myId = [value integerValue];
    }
    
}

-(NSString *)description
{

    return [NSString stringWithFormat:@"%@%@%ld%ld%@",_title,_releaseDate,_rMonth,_rDay,_type];

}

//@property(nonatomic,strong)NSString * image; // 图片网址
//@property(nonatomic,strong)NSString * title; // 标题
//@property(nonatomic,strong)NSString * releaseDate; // 上映日期
//@property(nonatomic,strong)NSString * type; // 影片类型
//@property(nonatomic,strong)NSString * director; // 导演
//@property(nonatomic,assign)NSInteger  wantedCount; // 想看的人数
//@property(nonatomic,strong)NSArray * videos;  // 预告片数组
//@property(nonatomic,assign)NSInteger  rDay;    // 上映的某一天
//@property(nonatomic,assign)NSInteger  rMonth;  // 上映的月份

@end
