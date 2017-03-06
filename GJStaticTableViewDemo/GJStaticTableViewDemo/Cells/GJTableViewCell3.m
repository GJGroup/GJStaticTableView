//
//  GJTableViewCell3.m
//  GJStaticTableViewDemo
//
//  Created by wangyutao on 2017/3/3.
//  Copyright © 2017年 wangyutao. All rights reserved.
//

#import "GJTableViewCell3.h"
#import <Masonry.h>

@implementation GJTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 15, 10, 15));
    }];
    label.text = @"Row Height:\n你可以让Cell实现GJStaticCellProtocol协议中的gj_rowHeight方法来设置cell的高度，这是优先级最高的；如果你想通过tableView的delegate进行高度设置，您只需按原有tableView的delegate使用方法即可，这将忽略GJStaticTableView提供的高度计算；如果你是用Autolayout布局，你可以直接通过Cell的intrinsicContentSize来将Cell的高度撑起，也就是通过Cell内部元素设置对Cell的顶部和底部的约束等，我们会使用依赖框架：FDTemplateLayoutCell来计算Cell的高度并进行设置。";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
