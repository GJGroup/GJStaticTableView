//
//  GJTableViewCell4.m
//  GJStaticTableViewDemo
//
//  Created by wangyutao on 2017/3/3.
//  Copyright © 2017年 wangyutao. All rights reserved.
//

#import "GJTableViewCell4.h"

@implementation GJTableViewCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.text = @"cell 4";
        self.detailTextLabel.text = @"detail text";
    }
    return self;
}

- (CGFloat)gj_rowHeight {
    return 80;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
