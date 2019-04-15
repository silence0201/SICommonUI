//
//  SIRollingView.m
//  SIUIKit
//
//  Created by Silence on 2019/4/15.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIRollingView.h"

@implementation SIRollingViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:CGRectZero]) {
        _reuseIdentifier = reuseIdentifier;
        
        self.backgroundColor = [UIColor whiteColor];
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
        
        _textLabel = [[UILabel alloc]init];
        [_contentView addSubview:_textLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithReuseIdentifier:@""];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]){
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentView.frame = self.bounds;
    _textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}

@end

@interface SIRollingView ()

@property (nonatomic, strong) NSMutableDictionary *cellClsDict;
@property (nonatomic, strong) NSMutableArray *reuseCells;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) SIRollingViewCell *currentCell;
@property (nonatomic, strong) SIRollingViewCell *willShowCell;
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation SIRollingView

#pragma mark -- Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}


- (void)setUp {
    self.clipsToBounds = YES;
    _stayInterval = 3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTapAction)];
    [self addGestureRecognizer:tap];
}

#pragma mark -- Public
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.cellClsDict setObject:NSStringFromClass(cellClass) forKey:identifier];
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [self.cellClsDict setObject:nib forKey:identifier];
}

- (void)reloadDataAndStartRoll {
    [self stopRoll];
    [self layoutCurrentCellAndWillShowCell];
    NSUInteger count = [self.dataSource numberOfRowsInrollingView:self];
    if (count && count < 2) {
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:_stayInterval target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark -- Private
- (__kindof SIRollingViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    for (SIRollingViewCell *cell in self.reuseCells) {
        if ([cell.restorationIdentifier isEqualToString:identifier]) {
            return cell;
        }
    }
    
    id cellClass = self.cellClsDict[identifier];
    SIRollingViewCell *cell = nil;
    if ([cellClass isKindOfClass:[UINib class]]) {
        UINib *nib = (UINib *)cellClass;
        NSArray *arr = [nib instantiateWithOwner:nil options:nil];
        cell = arr.firstObject;
        [cell setValue:identifier forKey:@"reuseIdentifier"];
    }else if ([cellClass isKindOfClass:[NSString class]]) {
        Class cellCls = NSClassFromString(cellClass);
        cell = [[cellCls alloc] initWithReuseIdentifier:identifier];
    }
    return cell;
}

- (void)layoutCurrentCellAndWillShowCell {
    NSUInteger count = (int)[self.dataSource numberOfRowsInrollingView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    NSUInteger willShowIndex = _currentIndex + 1;
    if (willShowIndex > count - 1) {
        willShowIndex = 0;
    }
    
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    
    if (!_currentCell) {
        _currentCell = [self.dataSource rollingView:self cellForRow:_currentIndex];
        _currentCell.frame  = CGRectMake(0, 0, w, h);
        [self addSubview:_currentCell];
        return;
    }
    
    _willShowCell = [self.dataSource rollingView:self cellForRow:willShowIndex];
    _willShowCell.frame = CGRectMake(0, h, w, h);
    [self addSubview:_willShowCell];
    [self.reuseCells removeObject:_currentCell];
    [self.reuseCells removeObject:_willShowCell];
}

- (void)stopRoll {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _isAnimating = NO;
    _currentIndex = 0;
    [_currentCell removeFromSuperview];
    [_willShowCell removeFromSuperview];
    _currentCell = nil;
    _willShowCell = nil;
    [self.reuseCells removeAllObjects];
}

#pragma mark -- Timer
- (void)timerHandle {
    if (self.isAnimating) return;
    [self layoutCurrentCellAndWillShowCell];
    _currentIndex ++;
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    self.isAnimating = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.currentCell.frame = CGRectMake(0, -h, w, h);
        self.willShowCell.frame = CGRectMake(0, 0, w, h);
    } completion:^(BOOL finished) {
        if (self.currentCell && self.willShowCell) {
            [self.reuseCells addObject:self.currentCell];
            [self.currentCell removeFromSuperview];
            self.currentCell = self.willShowCell;
        }
        self.isAnimating = NO;
    }];
}


#pragma mark -- Action
- (void)handleCellTapAction {
    NSUInteger count = [self.dataSource numberOfRowsInrollingView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    if ([self.delegate respondsToSelector:@selector(rollingView:didClickRow:)]) {
        [self.delegate rollingView:self didClickRow:_currentIndex];
    }
}

#pragma mark -- Getter
- (NSMutableDictionary *)cellClsDict {
    if (!_cellClsDict) {
        _cellClsDict = [NSMutableDictionary dictionary];
    }
    return _cellClsDict;
}

- (NSMutableArray *)reuseCells {
    if (!_reuseCells) {
        _reuseCells = [NSMutableArray array];
    }
    return _reuseCells;
}



@end
