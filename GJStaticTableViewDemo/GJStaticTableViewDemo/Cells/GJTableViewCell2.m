//
//  GJTableViewCell2.m
//  GJStaticTableViewDemo
//
//  Created by wangyutao on 2017/3/3.
//  Copyright © 2017年 wangyutao. All rights reserved.
//

#import "GJTableViewCell2.h"

@implementation GJTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contetnLabel.text = @"这是一个静态的TableView控件，你可以通过继承GJStaticTableView自定义你的TabelView，通常你只需在.h文件中使用@property按顺序声明你的Cell，即可在界面中看到你的Cells。";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
