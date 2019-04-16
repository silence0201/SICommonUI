//
//  ViewController.m
//  SIRollingView
//
//  Created by Silence on 2019/4/16.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"
#import <SIUIKit/SIRollingView.h>

@interface ViewController ()<SIRollingViewDelegate,SIRollingViewDataSource> {
    NSArray *_arr0;
    NSArray *_arr1;
}

@property (nonatomic, strong) SIRollingView *rollingView1;
@property (nonatomic, strong) SIRollingView *rollingView2;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr0 = @[@[@{@"tag": @"手机", @"title": @"小米千元全面屏：抱歉，久等！625献上"}, @{@"tag": @"萌宠", @"title": @"可怜狗狗被抛弃，苦苦等候主人半年"}],
              @[@{@"tag": @"手机", @"title": @"三星中端新机改名，全面屏火力全开"}, @{@"tag": @"围观", @"title": @"主人假装离去，狗狗直接把孩子推回去了"}],
              @[@{@"tag": @"园艺", @"title": @"学会这些，这5种花不用去花店买了"}, @{@"tag": @"手机", @"title": @"华为nova2S发布，剧透了荣耀10？"}],
              @[@{@"tag": @"开发", @"title": @"iOS 内购最新讲解"}, @{@"tag": @"博客", @"title": @"技术博客那些事儿"}]];
              
    _arr1 = @[@"小米千元全面屏：抱歉，久等！625献上",
              @"可怜狗狗被抛弃，苦苦等候主人半年",
              @"三星中端新机改名，全面屏火力全开",
              @"学会这些，这5种花不用去花店买了",
              @"华为nova2S发布，剧透了荣耀10？"];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    self.rollingView1.frame = CGRectMake(0, 190, width, 50);
    self.rollingView2.frame = CGRectMake(0, 290, width, 30);
    
    [self.view addSubview:self.rollingView1];
    [self.view addSubview:self.rollingView2];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rollingView1 reloadDataAndStartRoll];
    [self.rollingView2 reloadDataAndStartRoll];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.rollingView1 stopRoll];
    [self.rollingView2 stopRoll];
}

- (SIRollingView *)rollingView1 {
    if (!_rollingView1) {
        _rollingView1 = [[SIRollingView alloc]init];
        _rollingView1.delegate = self;
        _rollingView1.dataSource = self;
        _rollingView1.backgroundColor = [UIColor lightGrayColor];
        [_rollingView1 registerNib:[UINib nibWithNibName:@"DemoCell" bundle:nil] forCellReuseIdentifier:@"DemoCell"];
    }
    return _rollingView1;
}

- (SIRollingView *)rollingView2 {
    if (!_rollingView2) {
        _rollingView2 = [[SIRollingView alloc]init];
        _rollingView2.delegate = self;
        _rollingView2.dataSource = self;
        _rollingView2.backgroundColor = [UIColor lightGrayColor];
        [_rollingView2 registerClass:[SIRollingViewCell class] forCellReuseIdentifier:@"SIRollingViewCell"];
    }
    return _rollingView2;
}
              
    
#pragma mark -- Delegate
- (NSInteger)numberOfRowsInRollingView:(SIRollingView *)rollingView {
    if (rollingView == self.rollingView1) {
        return _arr0.count;
    } else if (rollingView == self.rollingView2) {
        return _arr1.count;
    }
    return 0;
}

- (SIRollingViewCell *)rollingView:(SIRollingView *)rollingView cellForRow:(NSUInteger)index {
    if (rollingView == self.rollingView1) {
        DemoCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"DemoCell"];
        [cell setInfo:_arr0[index]];
        return cell;
    }else if (rollingView == self.rollingView2) {
        SIRollingViewCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"SIRollingViewCell"];
        cell.textLabel.text = _arr1[index];
        return cell;
    }
    return nil;
}

- (void)rollingView:(SIRollingView *)rollingView didClickRow:(NSUInteger)index {
    NSLog(@"点击的Index:%lu", index);
}



@end
