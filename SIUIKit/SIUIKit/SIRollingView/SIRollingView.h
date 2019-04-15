//
//  SIRollingView.h
//  SIUIKit
//
//  Created by Silence on 2019/4/15.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SIRollingView;
@interface SIRollingViewCell : UIView

@property (nonatomic, strong, readonly) UIView   *contentView;
@property (nonatomic, strong, readonly) UILabel  *textLabel;
@property (nonatomic, copy,   readonly) NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

@protocol SIRollingViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsInrollingView:(SIRollingView *)rollingView;
- (SIRollingViewCell *)rollingView:(SIRollingView*)rollingView cellForRow:(NSUInteger)index;
@end

@protocol SIRollingViewDelegate <NSObject>
@optional
- (void)rollingView:(SIRollingView *)rollingView didClickRow:(NSUInteger)index;

@end

@interface SIRollingView : UIView

@property (nonatomic, weak) id<SIRollingViewDataSource> dataSource;
@property (nonatomic, weak) id<SIRollingViewDelegate> delegate;

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
