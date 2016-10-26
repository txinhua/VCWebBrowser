//
//  VCWebView.m
//  VCWeb
//
//  Created by VcaiTech on 16/7/5.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import "VCWebView.h"

#ifndef __IPHONE_8_0
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface VCWebView ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    UILabel *_domainLabel;
    UIWebView *_webView;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
}
@end

#else

@interface VCWebView ()<WKNavigationDelegate,WKUIDelegate>{
    UILabel *_domainLabel;
    WKWebView *_webView;
    CALayer *progresslayer;
}
@end

#endif

@implementation VCWebView

-(instancetype)init{
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
#ifdef __IPHONE_8_0
        _webView =[[WKWebView alloc]init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 2)];
        progress.backgroundColor = [UIColor clearColor];
        [self addSubview:progress];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = [UIColor blueColor].CGColor;
        [progress.layer addSublayer:layer];
        progresslayer = layer;
        
#else
        _webView =[[UIWebView alloc]init];
        CGRect barFrame = CGRectMake(0,
                                     0,
                                     CGRectGetWidth(frame),
                                     2);
        _webViewProgress = [[NJKWebViewProgress alloc] init];
        _webView.delegate = _webViewProgress;
        _webViewProgress.webViewProxyDelegate = self;
        _webViewProgress.progressDelegate = self;
        _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_webViewProgressView setProgress:0 animated:YES];
        [self addSubview:_webViewProgressView];
        
#endif
        
        [_webView setFrame:CGRectMake(0, 2, frame.size.width, frame.size.height-2)];
        
       _webView.backgroundColor = [UIColor colorWithRed:64/255.0 green:67/255.0 blue:68/255.0 alpha:1.0];
        
        _domainLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 20, frame.size.width, 20)];
        _domainLabel.backgroundColor = [UIColor clearColor];
        _domainLabel.textAlignment = NSTextAlignmentCenter;
        _domainLabel.font =[UIFont systemFontOfSize:14];
        _domainLabel.textColor =[UIColor colorWithRed:111/255.0 green:114/255.0 blue:120/255.0 alpha:1.0];
#ifdef __IPHONE_8_0
        [_webView insertSubview:_domainLabel belowSubview:_webView.scrollView];
#else
        [_webView insertSubview:_domainLabel belowSubview:_webView.scrollView];
#endif
        
        [self addSubview:_webView];
    }
    return self;
}

-(void)loadRequest:(NSURLRequest *)request{
    
    [_webView loadRequest:request];
    [self domainLabeSetContentFromRequest:request];
    
}

-(void)domainLabeSetContentFromRequest:(NSURLRequest *)request{
    
    NSString *domainStr =request.URL.host;
    [self setDomainInfo:domainStr];
}

-(void)setDomainInfo:(NSString *)info{
    
    if (info==nil||info.length==0) {
        _domainLabel.text =@"无法获取网页提供者";
//        _domainLabel.alpha = 0.0;
    }else{
//        _domainLabel.alpha = 1.0;
        _domainLabel.text =[NSString stringWithFormat:@"网页由 %@ 提供",info];
    }
}

-(void)dealloc{
#ifdef __IPHONE_8_0
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
#else
    [_webViewProgressView removeFromSuperview];
#endif
}



#ifdef __IPHONE_8_0

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        progresslayer.frame = CGRectMake(0, 0, self.bounds.size.width * [change[@"new"] floatValue], 2);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                progresslayer.frame = CGRectMake(0, 0, 0, 2);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
//    //允许跳转
//    decisionHandler(WKNavigationResponsePolicyAllow);
//    //不允许跳转
////    decisionHandler(WKNavigationResponsePolicyCancel);
//}
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSLog(@"%@",navigationAction.request.URL.absoluteString);
//    //允许跳转
//    decisionHandler(WKNavigationActionPolicyAllow);
//    //不允许跳转
////    decisionHandler(WKNavigationActionPolicyCancel);
//}

#else

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
}

#endif

@end
