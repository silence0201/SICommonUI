//
//  SIPickView.m
//  SIUIKit
//
//  Created by Silence on 2019/4/16.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIPickView.h"

#define IS_IPHONE_X_ALL \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define PICKWIDTH_HEIGHT         (IS_IPHONE_X_ALL ?  224 + 34.f : 224)

@implementation SIPickViewConfig

+ (instancetype)defaultConfig {
    SIPickViewConfig *defaultConfig = [[SIPickViewConfig alloc]init];
    defaultConfig.pickViewHeight = PICKWIDTH_HEIGHT;
    defaultConfig.componetRowHeight = 32.f;
    defaultConfig.selectRowTitleAttribute = [@{NSForegroundColorAttributeName : [UIColor orangeColor], NSFontAttributeName : [UIFont systemFontOfSize:20.0f]} mutableCopy];
    defaultConfig.unSelectRowTitleAttribute = [@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:20.0f]} mutableCopy];
    defaultConfig.selectRowLineBackgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    defaultConfig.isTouchBackgroundHide = YES;
    defaultConfig.isShowTipLabel = NO;
    defaultConfig.isShowSelectContent = NO;
    defaultConfig.isScrollToSelectedRow = NO;
    defaultConfig.isAnimationShow = YES;
    defaultConfig.backgroundAlpha = 0.5f;
    return defaultConfig;
}

@end

@implementation SIPickView
@end
