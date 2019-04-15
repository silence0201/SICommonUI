//
//  SIMarqueeView.h
//  SIUIKit
//
//  Created by Silence on 2019/4/15.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMarqueeViewCell : UIView

@property (nonatomic, strong, readonly) UIView   *contentView;
@property (nonatomic, strong, readonly) UILabel  *textLabel;
@property (nonatomic, copy,   readonly) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

@interface SIMarqueeView : UIView

@end

NS_ASSUME_NONNULL_END
