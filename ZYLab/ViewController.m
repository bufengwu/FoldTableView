//
//  ViewController.m
//  ZYLab
//
//  Created by DevKK on 2017/9/16.
//  Copyright © 2017年 DevKK. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])
#import "YYMGroup.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController {
    UITableView *_tableView;
    NSMutableArray *_titleArray;
    NSMutableArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self loadModel];
    
    [self.view addSubview:_tableView];
}

- (void)loadModel {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    _titleArray = [NSMutableArray arrayWithArray:@[@"明教", @"亮劍", @"三國"]];
    NSArray *groups = @[
                        @[@"张无忌", @"狄云", @"欧阳锋"],
                        @[@"李云龙", @"楚云飞"],
                        @[@"诸葛亮", @"王朗", @"司马懿", @"郭都督"]
                        ];
    
    for (NSArray *array in groups) {
        YYMGroup *group = [[YYMGroup alloc] init];
        group.isFolded = NO;
        group.items = array;
        group.size = array.count;
        [_dataArray addObject:group];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YYMGroup *group = _dataArray[section];
    return group.isFolded ? 0 : group.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    YYMGroup *group = _dataArray[indexPath.section];
    NSArray *items = group.items;
    
    cell.textLabel.text = items[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    label.text = _titleArray[section];
    label.tag = section + 200;      //避免tag=0
    label.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [label addGestureRecognizer:tapGesture];
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)click:(UIGestureRecognizer *)gestureRecognizer {
    
    NSInteger section = gestureRecognizer.view.tag - 200;
    YYMGroup *group = _dataArray[section];

    group.isFolded = !group.isFolded;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

@end
