//
//  MovieShopModel.m
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/21.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "MovieShopModel.h"

@implementation MovieShopModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.hotId = [value integerValue];
    }
}

@end
