//
//  ClearCacheHandle.h
//  36Kr
//
//  Created by Haipeng_Fu on 15/10/9.
//  Copyright (c) 2015年 Haipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearCacheHandle : NSObject

+ (ClearCacheHandle *)sharedManager;

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath;

// 清除缓存
- (void)clearCache;

@end
