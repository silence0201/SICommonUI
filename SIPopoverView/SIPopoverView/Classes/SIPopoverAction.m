//
//  SIPopoverAction.m
//  SIPopoverView
//
//  Created by Silence on 2019/4/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIPopoverAction.h"



@interface SIPopoverAction ()

@property (strong, nonatomic, readwrite) UIImage *image;
@property (copy, nonatomic,readwrite) NSString *title;
@property (copy, nonatomic, readwrite) PopClickAction action;

@end

@implementation SIPopoverAction

+ (instancetype)actionWithTitle:(NSString *)title action:(PopClickAction)action {
    return [self actionWithImage:nil title:title action:action];
}

+ (instancetype)actionWithImage:(nullable UIImage *)image title:(NSString *)title action:(PopClickAction)action {
    SIPopoverAction *popoverAction = [[self alloc]init];
    popoverAction.image = image;
    popoverAction.title = title ?: @"";
    popoverAction.action = action;
    
    return popoverAction;
}

@end
