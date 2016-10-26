//
//  VCWebBrowserController.m
//  VCWeb
//
//  Created by VcaiTech on 16/6/29.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "VCWebBrowserController.h"
#import "VCWebView.h"

@interface VCWebBrowserController ()
{
    VCWebView *_vcWebView;
}
@end


@implementation VCWebBrowserController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _vcWebView = nil;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    UINavigationBar *bar = self.navigationController.navigationBar;
    self.view.backgroundColor =[UIColor whiteColor];
    if (bar) {
        CGRect navBounds = bar.bounds;
        _vcWebView = [[VCWebView alloc]initWithFrame:CGRectMake(0, navBounds.size.height+20, navBounds.size.width, self.view.frame.size.height-(navBounds.size.height+20))];
    }else{
       _vcWebView = [[VCWebView alloc]initWithFrame:CGRectMake(0,20,self.view.frame.size.width, self.view.frame.size.height-20)];
    }
    [self.view addSubview:_vcWebView];
    [self processUrlRequest];
}


-(void)processUrlRequest
{
    //解决缓存后无法更新内容的问题
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?random=%d",_requestUrl,arc4random()]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_requestUrl]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    [_vcWebView loadRequest:request];
}

@end
