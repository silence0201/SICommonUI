//
//  ViewController.m
//  SIShadowView
//
//  Created by Silence on 2019/4/10.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <SIUIKit/SIShadowView.h>

@interface ViewController () {
    UIScrollView *scroll;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 50);
    [self.view addSubview:scroll];
    
    [self test1];
    [self test2];
    [self test3];
    [self test4];
    [self test5];
    [self test6];
    [self test7];

    
}

- (void)test1 {
    /// 圆角 + 阴影
    SIShadowView *v1 = [[SIShadowView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    v1.backgroundColor = [UIColor whiteColor];
    [v1 shaodw];
    [v1 cornerRadius:10];
    UILabel *label1 = [[UILabel alloc] initWithFrame:v1.bounds];
    label1.text = @"四周阴影\n四周圆角";
    label1.numberOfLines = 2;
    label1.textColor = [UIColor darkGrayColor];
    label1.font = [UIFont systemFontOfSize:13];
    label1.textAlignment = NSTextAlignmentCenter;
    [v1 addSubview:label1];
    [scroll addSubview:v1];
}

- (void)test2 {
    /// 单个圆角 + 阴影
    SIShadowView *v2 = [[SIShadowView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    v2.backgroundColor = [UIColor whiteColor];
    [v2 shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(SIShadowSideAllSides)];
    [v2 cornerRadius:10 byRoundingCorners:(UIRectCornerTopLeft)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:v2.bounds];
    label2.text = @"四周阴影\n单个圆角";
    label2.numberOfLines = 2;
    label2.textColor = [UIColor darkGrayColor];
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = NSTextAlignmentCenter;
    [v2 addSubview:label2];
    [scroll addSubview:v2];
}

- (void)test3 {
    /// 上下阴影 + 单个圆角
    SIShadowView *v3 = [[SIShadowView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    v3.backgroundColor = [UIColor whiteColor];
    [v3 verticalShaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeZero];
    [v3 cornerRadius:10 byRoundingCorners:(UIRectCornerTopRight)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:v3.bounds];
    label3.text = @"上下阴影\n单个圆角";
    label3.numberOfLines = 2;
    label3.textColor = [UIColor darkGrayColor];
    label3.font = [UIFont systemFontOfSize:13];
    label3.textAlignment = NSTextAlignmentCenter;
    [v3 addSubview:label3];
    [scroll addSubview:v3];
}

- (void)test4 {
    /// 单边阴影 + 单个圆角
    SIShadowView *v4 = [[SIShadowView alloc] initWithFrame:CGRectMake(200, 250, 100, 100)];
    v4.backgroundColor = [UIColor whiteColor];
    [v4 shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(SIShadowSideRight)];
    [v4 cornerRadius:10 byRoundingCorners:(UIRectCornerBottomLeft)];
    UILabel *label4 = [[UILabel alloc] initWithFrame:v4.bounds];
    label4.text = @"单边阴影\n单个圆角";
    label4.numberOfLines = 2;
    label4.textColor = [UIColor darkGrayColor];
    label4.font = [UIFont systemFontOfSize:13];
    label4.textAlignment = NSTextAlignmentCenter;
    [v4 addSubview:label4];
    [scroll addSubview:v4];
}

- (void)test5 {
    /// 上边阴影 + 上边圆角
    SIShadowView *v5 = [[SIShadowView alloc] initWithFrame:CGRectMake(50, 400, 100, 100)];
    v5.backgroundColor = [UIColor whiteColor];
    [v5 shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(SIShadowSideTop)];
    [v5 cornerRadius:10 byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    UILabel *label5 = [[UILabel alloc] initWithFrame:v5.bounds];
    label5.text = @"上边阴影\n上边圆角";
    label5.numberOfLines = 2;
    label5.textColor = [UIColor darkGrayColor];
    label5.font = [UIFont systemFontOfSize:13];
    label5.textAlignment = NSTextAlignmentCenter;
    [v5 addSubview:label5];
    [scroll addSubview:v5];
}

- (void)test6 {
    /// 下边阴影 + 下边圆角
    SIShadowView *v6 = [[SIShadowView alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
    v6.backgroundColor = [UIColor whiteColor];
    [v6 shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(SIShadowSideBottom)];
    [v6 cornerRadius:10 byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)];
    UILabel *label6 = [[UILabel alloc] initWithFrame:v6.bounds];
    label6.text = @"下边阴影\n下边圆角";
    label6.numberOfLines = 2;
    label6.textColor = [UIColor darkGrayColor];
    label6.font = [UIFont systemFontOfSize:13];
    label6.textAlignment = NSTextAlignmentCenter;
    [v6 addSubview:label6];
    [scroll addSubview:v6];
}

- (void)test7 {
    /// 图片
    SIShadowView *v7 = [[SIShadowView alloc] initWithFrame:CGRectMake(50, 600, 300, 150)];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img94"]];
    imageView.frame = v7.bounds;
    [v7 addSubview:imageView];
    [v7 shaodw];
    [v7 cornerRadius:25];
    [scroll addSubview:v7];
}

@end
