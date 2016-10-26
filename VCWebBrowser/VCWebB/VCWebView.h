//
//  VCWebView.h
//  VCWeb
//
//  Created by VcaiTech on 16/7/5.
//  Copyright © 2016年 VcaiTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef __IPHONE_8_0
#import <WebKit/WebKit.h>
#endif

@interface VCWebView : UIView
-(void)loadRequest:(NSURLRequest *)request;
@end






