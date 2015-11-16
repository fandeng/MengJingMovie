//
//  WebViewController.m
//  
//
//  Created by 周子钦 on 15/10/29.
//
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"影 象";
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:19], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem * BI = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClick)];
    [BI setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:19], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = BI;
    
    UIWebView * webView = [[UIWebView alloc] init];
    if (self.view.frame.size.width == 375) {
        webView.frame = CGRectMake(0, -51, self.view.frame.size.width, self.view.frame.size.height+51);
    } else if (self.view.frame.size.width == 320) {
        webView.frame = CGRectMake(0, -44, self.view.frame.size.width, self.view.frame.size.height+44);
    } else {
        webView.frame = CGRectMake(0, -57, self.view.frame.size.width, self.view.frame.size.height+57);
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];
}

- (void)didClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
