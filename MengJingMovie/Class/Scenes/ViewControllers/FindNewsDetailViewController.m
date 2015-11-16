//
//  FindNewsDetailViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright © 2015年 mengjing. All rights reserved.
//

#import "FindNewsDetailViewController.h"

#define TopHeight  450
@interface FindNewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *newsDetailImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *labeltime;

@property(nonatomic, strong)UILabel * contextLabel;

@property(nonatomic, strong)NSURL * url;


@property(nonatomic, strong)NSString * content;

@end

@implementation FindNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self TabBarController];
    [self parserURL];
    
    if (self.opinionNumber == 1) {
        self.LabelTitle.text = self.homeModel.title;
        [self.newsDetailImageView sd_setImageWithURL:[NSURL URLWithString:self.homeModel.img]];
    } else {
        self.LabelTitle.text = self.model.title;
        [self.newsDetailImageView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    }
    //内容
    _contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,CGRectGetMaxY(self.newsDetailImageView.frame),CGRectGetWidth(self.view.frame)-60, 0)];
    _contextLabel.font = [UIFont systemFontOfSize:12.0];
    _contextLabel.numberOfLines = 0;
    _contextLabel.backgroundColor = [UIColor whiteColor];
     [_scrollView addSubview:self.contextLabel];
    [[ShareAnimationLoad ShareAnimation]animationingLoad:self.view];
}
//解析数据
- (void)parserURL {
    
   // NSString * str = [NSString stringWithFormat:kFindNewsDetail(self.model.myId)];
    if (self.opinionNumber == 1) {
        self.url = [NSURL URLWithString:kFindNewsDetail((long)self.homeModel.hotId)];
    } else {
        self.url = [NSURL URLWithString:kFindNewsDetail((long)self.model.myId)];
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:_url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            
            [[ShareAnimationLoad ShareAnimation]animationSuccessLoad];
            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            
            self.content = dic[@"content"];
            
            self.labeltime.text =  [NSString stringWithFormat:@"%@ ",dic[@"time"]];
            [self flattenHTML:self.content];
            
        }
    }];
}
//过滤网页标签的方法
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    } // while //
    
    //NSLog(@"-----===%@",html);
    
    NSRange rang = [html rangeOfString:@"&nbsp;"];
    if (rang.length == 0) {
        
        self.contextLabel.text = html;
       
        [self adjustSubviewsWithContent:self.contextLabel.text];
    }else {
        
        self.contextLabel.text = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        
        [self adjustSubviewsWithContent:self.contextLabel.text];
    }
    return html;
}
//返回
- (void)TabBarController {
    
    UIBarButtonItem * LeftBI = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(click:)];
    self.navigationItem.leftBarButtonItem = LeftBI;
}
//返回上一级
- (void)click:(UIBarButtonItem *)BI {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//自适应高度
- (void)adjustSubviewsWithContent:(NSString *)content
{
    //计算活动内容的高度
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-60, 1000000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
   CGFloat height = TopHeight+contentRect.size.height+30;
    
    if (height < self.view.bounds.size.height) {
        
        height = self.view.bounds.size.height + 30;
    }
    _scrollView.contentSize = CGSizeMake(320, height);
    CGRect contentViewRect = _contextLabel.frame;
    contentViewRect.size.height = contentRect.size.height;
    _contextLabel.frame = contentViewRect;
}


@end
