//
//  ViewController.m
//  SIPopoverView
//
//  Created by Silence on 2019/4/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <SIUIKit/SIPopoverView.h>

#define IS_IPHONE_X_ALL \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define STATUS_BAR_ANDNAVIGATION_BAR_HEIGHT (IS_IPHONE_X_ALL ? 88.f : 64.f)

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@end

@implementation ViewController


- (NSArray<SIPopoverAction *> *)actions {
    // 发起多人聊天 action
    SIPopoverAction *multichatAction = [SIPopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_multichat"] title:@"发起多人聊天" action:^(SIPopoverAction * _Nonnull action) {
        // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        self.noticeLabel.text = action.title;
    }];
    // 加好友 action
    SIPopoverAction *addFriAction = [SIPopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"加好友" action:^(SIPopoverAction * _Nonnull action) {
        // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        self.noticeLabel.text = action.title;
    }];
    // 扫一扫 action
    SIPopoverAction *QRAction = [SIPopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"扫一扫" action:^(SIPopoverAction * _Nonnull action) {
        // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        self.noticeLabel.text = action.title;
    }];
    // 付款 action
    SIPopoverAction *payMoneyAction = [SIPopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"付款" action:^(SIPopoverAction * _Nonnull action) {
        // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        self.noticeLabel.text = action.title;
    }];
    
    return @[multichatAction, addFriAction, QRAction, payMoneyAction];
}

- (IBAction)buttonAction:(UIButton *)sender {
    SIPopoverView *popoverView = [SIPopoverView popoverView];
    popoverView.arrowStyle = SIPopoverViewArrowStyleTriangle;
    [popoverView showToView:sender withActions:[self actions]];
}

- (IBAction)leftButtonAction:(UIBarButtonItem *)sender {
    SIPopoverView *popoverView = [SIPopoverView popoverView];
    popoverView.arrowStyle = SIPopoverViewArrowStyleTriangle;
    popoverView.style = SIPopoverViewStyleDark;
    [popoverView showToPoint:CGPointMake(20, STATUS_BAR_ANDNAVIGATION_BAR_HEIGHT) withActions:[self actions]];
}

- (IBAction)bundleTest:(id)sender {
    NSString *testPath = [[NSBundle mainBundle] pathForResource:@"SIUIKitBundle" ofType:@"bundle"];
    NSBundle *testBundle = [NSBundle bundleWithPath:testPath];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Test" bundle:testBundle];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"test"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
