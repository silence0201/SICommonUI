//
//  SIMarqueeView.h
//  SIUIKit
//
//  Created by Silence on 2019/4/15.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SIMarqueeView;
@interface SIMarqueeViewCell : UIView

@property (nonatomic, strong, readonly) UIView   *contentView;
@property (nonatomic, strong, readonly) UILabel  *textLabel;
@property (nonatomic, copy,   readonly) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

@protocol SIMarqueeViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsInMarqueeView:(SIMarqueeView *)marqueeView;
- (SIMarqueeViewCell *)marqueeView:(SIMarqueeView*)marqueeView cellForRow:(NSUInteger)index;
@end

@protocol SIMarqueeViewDelegate <NSObject>
@optional
- (void)marqueeView:(SIMarqueeView *)marqueeView didClickRow:(NSUInteger)index;

@end

@interface SIMarqueeView : UIView

@property (nonatomic, weak) id<SIMarqueeViewDataSource> dataSource;
@property (nonatomic, weak) id<SIMarqueeViewDelegate> delegate;

/// 停留时间,默认3s
@property (nonatomic, assign) NSTimeInterval stayInterval;
/// 当前选择index
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;

- (void)reloadDataAndStartRoll;
- (void)stopRoll;

@end

NS_ASSUME_NONNULL_END
