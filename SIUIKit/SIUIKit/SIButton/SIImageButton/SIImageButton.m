//
//  SIImageButton.m
//  SIUIKit
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019 Silence. All rights reserved.
//

#import "SIImageButton.h"

@implementation SIImageButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.spacing = 5.0;
    }
    return self;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self setupContentAlignment];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self setupContentAlignment];
}

- (void)setContentAlignment:(SIContentAlignment)contentAlignment {
    _contentAlignment = contentAlignment;
    [self setupContentAlignment];
}

- (void)setupContentAlignment {
    // 获取图文size
    CGFloat image_w = self.imageView.bounds.size.width;
    CGFloat image_h = self.imageView.bounds.size.height;
    CGFloat title_w = self.titleLabel.bounds.size.width;
    CGFloat title_h = self.titleLabel.bounds.size.height;
    
    UIEdgeInsets imageEdgeInset = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInset = UIEdgeInsetsZero;
    // 执行switch
    switch (self.contentAlignment) {
        case SIContentAlignmentNormal:
        {
            imageEdgeInset = UIEdgeInsetsMake(0, 0, 0, self.spacing);
            titleEdgeInset = UIEdgeInsetsMake(0, self.spacing, 0, 0);
            break;
        }
        case SIContentAlignmentCenterImageRight:
        {
            imageEdgeInset = UIEdgeInsetsMake(0, title_w + self.spacing, 0, -title_w);
            titleEdgeInset = UIEdgeInsetsMake(0, -image_w - self.spacing, 0, image_w);
            break;
        }
        case SIContentAlignmentCenterImageTop:
        {
            imageEdgeInset = UIEdgeInsetsMake(-title_h - self.spacing, 0, 0, -title_w);
            titleEdgeInset = UIEdgeInsetsMake(0, -image_w, -image_h - self.spacing, 0);
            break;
        }
        case SIContentAlignmentCenterImageBottom:
        {
            imageEdgeInset = UIEdgeInsetsMake(0, 0, -title_h - self.spacing, -title_w);
            titleEdgeInset = UIEdgeInsetsMake(-image_h - self.spacing, -image_w, 0, 0);
            break;
        }
        case SIContentAlignmentLeftImageLeft:
        {
            imageEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
            titleEdgeInset = UIEdgeInsetsMake(0, self.spacing, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            break;
        }
        case SIContentAlignmentLeftImageRight:
        {
            imageEdgeInset = UIEdgeInsetsMake(0, title_w + self.spacing, 0, 0);
            titleEdgeInset = UIEdgeInsetsMake(0, -image_w, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            break;
        }
        case SIContentAlignmentRightImageLeft:
        {
            imageEdgeInset = UIEdgeInsetsMake(0, 0, 0, self.spacing);
            titleEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            break;
        }
        case SIContentAlignmentRightImageRight:
        {
            imageEdgeInset = UIEdgeInsetsMake(0, 0, 0, -title_w);
            titleEdgeInset = UIEdgeInsetsMake(0, 0, 0, image_w + self.spacing);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            break;
        }
        default:
            break;
    }
    
    // 赋值edgeInset
    self.imageEdgeInsets = imageEdgeInset;
    self.titleEdgeInsets = titleEdgeInset;
}

@end
