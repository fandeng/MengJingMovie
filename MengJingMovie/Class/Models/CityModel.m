//
//  CityModel.m
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {

        self.cityId = [value integerValue];
    }
    
    if ([key isEqualToString:@"n"]) {
        
        self.cityName = value;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%ld  %@", (long)_cityId,_cityName];
}

@end
