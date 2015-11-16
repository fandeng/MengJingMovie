//
//  NSString+Characters.m
//  AddressBook
//
//  Created by y_小易 on 14-6-10.
//  Copyright (c) 2014年 www.mengjing.com. All rights reserved.
//

#import "NSString+Characters.h"

@implementation NSString (Characters)

//讲汉字转换为拼音
- (NSString *)pinyinOfString
{
    NSMutableString * string = [[[NSMutableString alloc] initWithString:self ] autorelease];
    
    CFRange range = CFRangeMake(0, [string length]);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) string, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) string, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    return string;
}

//汉字转换为拼音后，返回大写的首字母
- (NSString *)firstCharacterOfString
{
    
    NSMutableString * first = [[[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]] autorelease];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    return result.uppercaseString;
}
@end
