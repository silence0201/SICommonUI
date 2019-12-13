//
//  SIImageButton.h
//  SIUIKit
//
//  Created by Silence on 2019/12/13.
//  Copyright © 2019 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SIContentAlignment) {
    SIContentAlignmentNormal = 0,                       //内容居中>>图左文右
    SIContentAlignmentCenterImageRight,                 //内容居中>>图右文左
    SIContentAlignmentCenterImageTop,                   //内容居中>>图上文右
    SIContentAlignmentCenterImageBottom,                //内容居中>>图下文上
    SIContentAlignmentLeftImageLeft,                    //内容居左>>图左文右
    SIContentAlignmentLeftImageRight,                   //内容居左>>图右文左
    SIContentAlignmentRightImageLeft,                   //内容居右>>图左文右
    SIContentAlignmentRightImageRight                   //内容居右>>图右文左
};

NS_ASSUME_NONNULL_BEGIN

@interface SIImageButton : UIButton

// 对齐方式
@property (nonatomic, assign) SIContentAlignment contentAlignment;
// 图文间距[默认5.0]
@property (nonatomic, assign) CGFloat spacing;

@end

NS_ASSUME_NONNULL_END
