//
//  ViewController.m
//  VCWebBrowser
//
//  Created by VcaiTech on 2016/10/26.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import "ViewController.h"
#import "VCWebBrowserController.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)showBrowser:(id)sender {
    
    VCWebBrowserController *browser =[[VCWebBrowserController alloc]init];
    browser.requestUrl = @"https://m.baidu.com";
    [self.navigationController pushViewController:browser animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
