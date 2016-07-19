//
//  ViewController.m
//  TestDetectionUrl
//
//  Created by 王然 on 16/7/18.
//  Copyright © 2016年 wangran. All rights reserved.
//

#import "ViewController.h"
#import "DetectionUrlView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DetectionUrlView * view = [[DetectionUrlView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    [self.view addSubview:view];
    [view resetDetectionTextColor:[UIColor whiteColor] highlightTextColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:16] canClickColor:[UIColor greenColor] isClickHaveLine:YES];
    [view detectionWithStr:@"有一个网址：http://blog.csdn.net/lengshengren/article/details/43971441S555 7有一个电话：15310547654 还有一个 地址：闸北区万荣路1188号" clickTextFont:[UIFont boldSystemFontOfSize:16] textCheckType:NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber | NSTextCheckingTypeAddress];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
