//
//  LCinemaModel.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "LCinemaModel.h"

@implementation LCinemaModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{



}

-(NSString *)description
{
     return [NSString stringWithFormat:@"%@ %@ %ld %f",_cinameName,_address,_minPrice,_ratingFinal];

}


@end
