//
//  SIMarqueeView.m
//  SIUIKit
//
//  Created by Silence on 2019/4/15.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIMarqueeView.h"

@implementation SIMarqueeViewCell

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

@implementation SIMarqueeView


@end
