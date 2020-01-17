//
//  LWViewController.m
//  LWPopupViewController
//
//  Created by zhongzhiyuan on 01/17/2020.
//  Copyright (c) 2020 zhongzhiyuan. All rights reserved.
//

#import "LWViewController.h"
#import "LWPopupViewController.h"
#import "Masonry.h"
#import "CustomAlertViewController.h"

#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

@interface LWViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSArray * _tableviewData;
}
@property(strong, nonatomic)UITableView *tableView;
@end

@implementation LWViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"LWPopupViewController";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    _tableviewData = @[
        @"居中PopupView",
        @"相对定位Popupview"
    ];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell * cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = _tableviewData[indexPath.row];
        return cell;
    
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CustomAlertViewController *vc = [CustomAlertViewController new];
        LWPopupViewController *pop = [LWPopupViewController new];
        pop.shouldDisableBgTap = true;
        [pop addContentController: vc];
        
        kWeakSelf(pop)
        vc.clickEventBlock = ^(NSInteger index) {
            kStrongSelf(pop)
//            if(index == 0) { //cancel
                [pop hidden];
//            }
        };
        [pop showWithViewController:self.navigationController];
    }
}

@end
