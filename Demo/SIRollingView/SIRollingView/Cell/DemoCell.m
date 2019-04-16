//
//  DemoCell.m
//  SIRollingView
//
//  Created by Silence on 2019/4/16.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "DemoCell.h"

@interface DemoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *trailIconImgView;

@property (weak, nonatomic) IBOutlet UILabel *tagLab0;
@property (weak, nonatomic) IBOutlet UILabel *titleLab0;

@property (weak, nonatomic) IBOutlet UILabel *tagLab1;
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;

@end

@implementation DemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _tagLab0.layer.borderColor = [UIColor orangeColor].CGColor;
    _tagLab0.layer.borderWidth = 0.5;
    _tagLab0.layer.cornerRadius = 3;
    
    _tagLab1.layer.borderColor = [UIColor orangeColor].CGColor;
    _tagLab1.layer.borderWidth = 0.5;
    _tagLab1.layer.cornerRadius = 3;
}

- (void)setInfo:(NSArray *)array {
    _tagLab0.text = [array firstObject][@"tag"];
    _titleLab0.text = [array firstObject][@"title"];
    _tagLab1.text = [array lastObject][@"tag"];
    _titleLab1.text = [array lastObject][@"title"];
}


@end
