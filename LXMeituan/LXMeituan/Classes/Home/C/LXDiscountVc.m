//
//  LXDiscountVc.m
//  LXMeituan
//
//  Created by Noki on 2017/4/11.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXDiscountVc.h"

@interface LXDiscountVc ()<UIWebViewDelegate>{
    UIActivityIndicatorView * _activityView;
    UIWebView * _webView;
}

@end

@implementation LXDiscountVc
-(instancetype)initWithUrlString:(NSString *)url{
    if (self=[super init]) {
        self.urlStr=url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    [self setWebView];
}
-(void)setWebView{
    UIWebView * webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, LXScreen_height-64)];
    _webView=webView;
    webView.scalesPageToFit=YES;
    webView.delegate=self;
    [self.view addSubview:_webView];
    NSURLRequest *quest=[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [webView loadRequest:quest];
    
    _activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(LXScreen_width/2-15, LXScreen_height/2-15, 30, 30)];
    _activityView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped=YES;
    [self.view addSubview:_activityView];
    [self.view bringSubviewToFront:_activityView];
}

#pragma mark webViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title=title;
    [_activityView startAnimating];
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title=theTitle;
    [_activityView stopAnimating];
}


@end
