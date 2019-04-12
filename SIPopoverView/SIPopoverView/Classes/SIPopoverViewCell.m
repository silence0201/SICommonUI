//
//  SIPopoverViewCell.m
//  SIPopoverView
//
//  Created by Silence on 2019/4/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIPopoverViewCell.h"

CGFloat const SIPopoverViewCellHorizontalMargin = 15.f;
CGFloat const SIPopoverViewCellVerticalMargin = 3.f;
CGFloat const SIPopoverViewCellTitleLeftEdge = 8.f;

@interface SIPopoverViewCell ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation SIPopoverViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [self highlightedColor:self.style];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundColor = [UIColor clearColor];
        }];
    }
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.button];
    [self.contentView addSubview:self.bottomView];
    
    // Constraint
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{@"margin" : @(SIPopoverViewCellHorizontalMargin)} views:NSDictionaryOfVariableBindings(_button)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_button]-margin-|" options:kNilOptions metrics:@{@"margin" : @(SIPopoverViewCellVerticalMargin)} views:NSDictionaryOfVariableBindings(_button)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_bottomView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomView(lineHeight)]|" options:kNilOptions metrics:@{@"lineHeight" : @(1/[UIScreen mainScreen].scale)} views:NSDictionaryOfVariableBindings(_bottomView)]];
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.userInteractionEnabled = NO;
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        _button.backgroundColor = self.contentView.backgroundColor;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _button.titleLabel.font = [self.class titleFont];
        [_button setTitleColor:[self titleColor:SIPopoverViewStyleDefault] forState:UIControlStateNormal];
    }
    return _button;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

#pragma mark -- 供重写
+ (UIFont *)titleFont {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];//这个是9.0以后自带的平方字体
    if (!font) font = [UIFont systemFontOfSize:15];
    return font;
}

- (UIColor *)titleColor:(SIPopoverViewStyle)style {
    if (style == SIPopoverViewStyleDefault) {
        return [UIColor darkTextColor];
    }
    return [UIColor lightTextColor];
}

- (UIColor *)highlightedColor:(SIPopoverViewStyle)style {
    if (style == SIPopoverViewStyleDefault) {
        return [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    }
    return [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.00];
}

+ (UIColor *)bottomLineColorForStyle:(SIPopoverViewStyle)style {
    if (style == SIPopoverViewStyleDefault) {
        return [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00];
    }
    return [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.00];
}

#pragma mark -- 设置模型
- (void)setStyle:(SIPopoverViewStyle)style {
    _style = style;
    _bottomView.backgroundColor = [self.class bottomLineColorForStyle:style];
    [_button setTitleColor:[self titleColor:style] forState:UIControlStateNormal];
}

- (void)setAction:(SIPopoverAction *)action {
    [_button setImage:action.image forState:UIControlStateNormal];
    [_button setTitle:action.title forState:UIControlStateNormal];
    _button.titleEdgeInsets = action.image ? UIEdgeInsetsMake(0, SIPopoverViewCellTitleLeftEdge, 0, -SIPopoverViewCellTitleLeftEdge) : UIEdgeInsetsZero;
}

- (void)showBottomLine:(BOOL)show {
    _bottomView.hidden = !show;
}

@end
