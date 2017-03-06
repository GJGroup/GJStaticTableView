//
//  GJTableViewCell3.m
//  GJStaticTableViewDemo
//
//  Created by wangyutao on 2017/3/3.
//  Copyright © 2017年 wangyutao. All rights reserved.
//

#import "GJTableViewCell3.h"

@implementation GJTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textLabel.text = @"cell 3";
}

- (CGFloat)gj_rowHeight {
    return 50;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
