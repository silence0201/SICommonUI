//
//  SIPickView.h
//  SIUIKit
//
//  Created by Silence on 2019/4/16.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SIPickViewClickAction)(NSString *content); // 多行用 "," 分割

@interface SIPickViewConfig : NSObject

/// PickView 高度
@property (assign, nonatomic) CGFloat pickViewHeight;
/// Componet 高度
@property (assign, nonatomic) CGFloat componetRowHeight;

/// 顶部工具条分割线背景颜色
@property (strong, nonatomic) UIColor *lineViewColor;

/// 是否点击背景隐藏,默认YES
@property (nonatomic, assign) BOOL isTouchBackgroundHide;
/// 是否显示提示标签
@property (nonatomic, assign) BOOL isShowTipLabel;
/// 选择内容后是否更新选择提示标签
@property (nonatomic, assign) BOOL isShowSelectContent;
/// 将要显示时是否滚动到已选择内容那一行，注意，选择提示标签tipTitle必须传内容
@property (nonatomic, assign) BOOL isScrollToSelectedRow;
/// 显示pickerView时是否带动画效果,默认YES
@property (nonatomic, assign) BOOL isAnimationShow;
/// 背景视图透明度,默认0.5
@property (nonatomic, assign) CGFloat backgroundAlpha;

/// 取消按钮标题
@property (copy, nonatomic) NSString *cancelBtnTitle;
/// 确定按钮标题
@property (copy, nonatomic) NSString *sureBtnTitle;
/// 提示标签标题
@property (copy, nonatomic) NSString *tipTitle;

/// 取消按钮标题颜色
@property (strong, nonatomic) UIColor *cancelBtnTitleColor;
/// 确定按钮标题颜色
@property (strong, nonatomic) UIColor *sureBtnTitleColor;
/// 提示标签标题颜色
@property (strong, nonatomic) UIColor *tipTitleColor;

/// 取消按钮标题字体
@property (strong, nonatomic) UIFont *cancelBtnTitleFont;
/// 确定按钮标题字体
@property (strong, nonatomic) UIFont *sureBtnTitleFont;
/// 提示标签标题字体
@property (strong, nonatomic) UIFont *tipTitleFont;

/// pickerView当前选中的文字样式
@property (nonatomic, strong) NSMutableDictionary<NSAttributedStringKey, id> *selectRowTitleAttribute;
/// pickerView当前没有选中的文字颜色
@property (nonatomic, strong) NSMutableDictionary<NSAttributedStringKey, id> *unSelectRowTitleAttribute;

/// 选中行顶部和底部分割线背景颜色
@property (nonatomic, strong) UIColor *selectRowLineBackgroundColor;

/// 默认初始化
+ (instancetype)defaultConfig;

@end

@interface SIPickView : UIView

- (instancetype)initWithDataSouce:(NSArray *)dataSource
                           config:(SIPickViewConfig *)config
                      clickAction:(SIPickViewClickAction)action;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
