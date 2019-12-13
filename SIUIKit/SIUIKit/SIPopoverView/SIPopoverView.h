//
//  SIPopoverView.h
//  SIPopoverView
//
//  Created by Silence on 2019/4/12.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SIPopoverViewStyle) {
    SIPopoverViewStyleDefault = 0, // 默认风格, 白色
    SIPopoverViewStyleDark, // 黑色风格
};

// 弹窗箭头的样式
typedef NS_ENUM(NSUInteger, SIPopoverViewArrowStyle) {
    SIPopoverViewArrowStyleRound = 0, // 圆角
    SIPopoverViewArrowStyleTriangle   // 菱角
};

NS_ASSUME_NONNULL_BEGIN

// 重用Cell标识,用于重写自定义样式
FOUNDATION_EXPORT NSString * const kPopoverCellReuseId;

@class SIPopoverAction;
typedef void(^PopClickAction)(SIPopoverAction *action);

@interface SIPopoverAction : NSObject

@property (strong, nonatomic, readonly) UIImage *image;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) PopClickAction action;

+ (instancetype)actionWithTitle:(NSString *)title action:(PopClickAction)action;
+ (instancetype)actionWithImage:(nullable UIImage *)image title:(NSString *)title action:(PopClickAction)action;

@end

@interface SIPopoverView : UIView

/// 是否开启点击外部隐藏弹窗, 默认为YES.
@property (nonatomic, assign) BOOL hideAfterTouchOutside;

/// 是否显示阴影, 如果为YES则弹窗背景为半透明的阴影层, 否则为透明, 默认为NO.
@property (nonatomic, assign) BOOL showShade;

/// 弹出窗风格, 默认为 PopoverViewStyleDefault(白色).
@property (nonatomic, assign) SIPopoverViewStyle style;

///  箭头样式, 默认为 PopoverViewArrowStyleRound,如果要修改箭头的样式, 需要在显示先设置.
@property (nonatomic, assign) SIPopoverViewArrowStyle arrowStyle;

+ (instancetype)popoverView;

/**
 指向指定的View来显示弹窗
 
 @param pointView 箭头指向的View
 @param actions 动作对象集合<PopoverAction>
 */
- (void)showToView:(UIView *)pointView withActions:(NSArray<SIPopoverAction *> *)actions;

/**
 指向指定的点来显示弹窗
 
 @param toPoint 箭头指向的点(这个点的坐标需按照keyWindow的坐标为参照)
 @param actions 动作对象集合<PopoverAction>
 */
- (void)showToPoint:(CGPoint)toPoint withActions:(NSArray<SIPopoverAction *> *)actions;


/// 重写覆盖,并实现TableView的代理即可
@property (nonatomic, copy, readonly) NSArray<SIPopoverAction *> *actions;
+ (Class)cellClass;

@end

NS_ASSUME_NONNULL_END
