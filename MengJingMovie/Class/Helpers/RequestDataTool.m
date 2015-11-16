//
//  ShareRequestData.m
//  Homepage_MengJingMovies
//
//  Created by mengjing on 15/10/20.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "RequestDataTool.h"
#import "AFNetworking.h"
@implementation RequestDataTool

#pragma mark ----自定义初始化，请求数据 最外层是字典
- (instancetype)initWithUrlByString:(NSString *)urlString
{
    self = [super init];
    
    if (self) {
        NSURL * url = [NSURL URLWithString:urlString];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *html = operation.responseString;
            
            NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
            
            id dict = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            
            if ([_datesource respondsToSelector:@selector(requestData:didSucceedWithDic:)]) {
                
                [_datesource requestData:self didSucceedWithDic:dict];
            }
            if ([_delegate respondsToSelector:@selector(requestData:succeedWithDic:)]) {
                
                [_delegate requestData:self succeedWithDic:dict];
            }
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            CLog(@"发生错误！%@",error);
            
        }];
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        [queue addOperation:operation];
    }
    return self;
}

#pragma mark ----自定义初始化，请求数据 最外层是数组
- (instancetype)initWithGetArrayByUrlString:(NSString *)urlString
{
    self = [super init];
    
    if (self) {
        NSURL * url = [NSURL URLWithString:urlString];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *html = operation.responseString;
            
            NSData* data = [html dataUsingEncoding:NSUTF8StringEncoding];
            
            id array = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            
            if ([_datesource respondsToSelector:@selector(requestData:didSucceedWithArray:)]) {
                
                [_datesource requestData:self didSucceedWithArray:array];
            }
            if ([_delegate respondsToSelector:@selector(requestData:succeedWithArray:)]) {
                
                [_delegate requestData:self succeedWithArray:array];
            }

        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            CLog(@"发生错误！%@",error);
            
        }];
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        [queue addOperation:operation];
    }
    return self;
}

- (void)dealloc
{
    _datesource = nil;
    
    _delegate = nil;
}

@end
