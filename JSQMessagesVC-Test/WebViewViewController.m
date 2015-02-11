//
//  WebViewViewController.m
//  JSQMessagesVC-Test
//
//  Created by Jian Yao Ang on 2/11/15.
//  Copyright (c) 2015 Jian Yao Ang. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *theWebView;

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theWebView.delegate = self;
    self.theWebView.scalesPageToFit = YES;
    
    NSURL *url = self.url;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.theWebView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error");
}



@end
