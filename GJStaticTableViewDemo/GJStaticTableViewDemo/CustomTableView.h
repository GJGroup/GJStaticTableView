//
//  CustomTableView.h
//  GJStaticTableViewDemo
//
//  Created by wangyutao on 2017/3/3.
//  Copyright © 2017年 wangyutao. All rights reserved.
//  

#import "GJStaticTableView.h"
#import "GJTableViewCell1.h"
#import "GJTableViewCell2.h"
#import "GJTableViewCell3.h"
#import "GJTableViewCell4.h"

@interface CustomTableView : GJStaticTableView
@property (nonatomic, strong) GJTableViewCell1 *cell1;
@property (nonatomic, strong) GJTableViewCell2 *cell2;
@property (nonatomic, strong) GJTableViewCell3 *cell3;
@property (nonatomic, strong) GJTableViewCell4 *cell4;

@end
