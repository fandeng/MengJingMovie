//
//  HtmlDetailsViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/30.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "HtmlDetailsViewController.h"

@interface HtmlDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HtmlDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
    self.webView.scalesPageToFit = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
