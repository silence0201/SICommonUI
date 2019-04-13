//
//  SIPopoverViewCell.h
//  SIPopoverView
//
//  Created by Silence on 2019/4/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIPopoverView.h"

FOUNDATION_EXPORT CGFloat const SIPopoverViewCellHorizontalMargin;
FOUNDATION_EXPORT CGFloat const SIPopoverViewCellVerticalMargin;
FOUNDATION_EXPORT CGFloat const SIPopoverViewCellTitleLeftEdge;

NS_ASSUME_NONNULL_BEGIN
@interface SIPopoverViewCell : UITableViewCell

@property (nonatomic, assign) SIPopoverViewStyle style;

// 重写实现自定义样式
+ (UIFont *)titleFont;
- (UIColor *)titleColor:(SIPopoverViewStyle)style;
- (UIColor *)highlightedColor:(SIPopoverViewStyle)style;

+ (UIColor *)bottomLineColorForStyle:(SIPopoverViewStyle)style;

// 设置模型
- (void)setAction:(SIPopoverAction *)action;

- (void)showBottomLine:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
