//
//  SIPopoverAction.h
//  SIPopoverView
//
//  Created by Silence on 2019/4/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SIPopoverViewStyle) {
    SIPopoverViewStyleDefault = 0, // 默认风格, 白色
    SIPopoverViewStyleDark, // 黑色风格
};

NS_ASSUME_NONNULL_BEGIN

@class SIPopoverAction;
typedef void(^PopClickAction)(SIPopoverAction *action);

@interface SIPopoverAction : NSObject

@property (strong, nonatomic, readonly) UIImage *image;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) PopClickAction action;

+ (instancetype)actionWithTitle:(NSString *)title action:(PopClickAction)action;
+ (instancetype)actionWithImage:(nullable UIImage *)image title:(NSString *)title action:(PopClickAction)action;

@end

NS_ASSUME_NONNULL_END
