//
//  ViewController.m
//  GJStaticTableViewDemo
//
//  Created by wangyutao on 2017/3/3.
//  Copyright © 2017年 wangyutao. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableView.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface ViewController () <UITableViewDelegate>
@property (nonatomic, strong) CustomTableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[CustomTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 1) {
//        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(self.tableView.cell2.class) configuration:^(id cell) {}];
//    }
//    return 40;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
