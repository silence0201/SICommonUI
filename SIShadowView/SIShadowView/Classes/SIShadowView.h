//
//  SIShadowView.h
//  SIShadowView
//
//  Created by Silence on 2019/4/10.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIShadowView : UIView

typedef NS_OPTIONS(NSUInteger, SIShadowSide) {
    SIShadowSideTop       = 1 << 0,
    SIShadowSideBottom    = 1 << 1,
    SIShadowSideLeft      = 1 << 2,
    SIShadowSideRight     = 1 << 3,
    SIShadowSideAllSides  = ~0UL
};

/**
 * 设置四周阴影: shaodwRadius:5  shadowColor:[UIColor colorWithWhite:0 alpha:0.3]
 */
- (void)shaodw;

/**
 * 设置垂直方向的阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 */
- (void)verticalShaodwRadius:(CGFloat)shadowRadius
                 shadowColor:(UIColor *)shadowColor
                shadowOffset:(CGSize)shadowOffset;

/**
 * 设置水平方向的阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 */
- (void)horizontalShaodwRadius:(CGFloat)shadowRadius
                   shadowColor:(UIColor *)shadowColor
                  shadowOffset:(CGSize)shadowOffset;

/**
 * 设置阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 * @param shadowSide     阴影边
 */
- (void)shaodwRadius:(CGFloat)shadowRadius
         shadowColor:(UIColor *)shadowColor
        shadowOffset:(CGSize)shadowOffset
        byShadowSide:(SIShadowSide)shadowSide;

/**
 * 设置圆角（四周）
 *
 * @param cornerRadius   圆角半径
 */
- (void)cornerRadius:(CGFloat)cornerRadius;

/**
 * 设置圆角
 *
 * @param cornerRadius   圆角半径
 * @param corners        圆角边
 */
- (void)cornerRadius:(CGFloat)cornerRadius
   byRoundingCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
