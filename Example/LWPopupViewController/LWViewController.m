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
        @"居中ViewController",
        @"居中ViewController(显示于navigation)",
        @"相对定位ViewController",
        @"居中View",
        @"直接加载到KeyWindow上",
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
    return _tableviewData.count;
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
    CustomAlertViewController *vc = [CustomAlertViewController new];
    LWPopupViewController *pop = [LWPopupViewController new];
    pop.shouldDisableBgTap = true;
    [pop addContentController: vc];
    
    kWeakSelf(pop)
    vc.clickEventBlock = ^(NSInteger index) {
        kStrongSelf(pop)
        [pop hidden];
    };
    
    if (indexPath.row == 0) {
        [pop showWithViewController:self];
    } else if (indexPath.row == 1) {
        [pop showWithViewController:self.navigationController];
        
    } else if (indexPath.row == 2) {
        pop.bgViewColor = [UIColor clearColor];
        pop.shouldDisableBgTap = false;
        [pop showWithViewController:self];
        
        [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tableView).offset(20);
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
            make.width.mas_equalTo(200);
        }];
    } else if (indexPath.row == 3) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blueColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        
         pop = [LWPopupViewController new];
        [pop addContentView:view];
        [pop showWithViewController:self.navigationController];
    } else if (indexPath.row == 4) {

//        [pop showWithViewController:self];
        
        pop.shouldDisableBgTap = false;
//        [[UIApplication sharedApplication].keyWindow addSubview:pop.view];
        [pop showWithView:[UIApplication sharedApplication].keyWindow];
        //注意！！！---如果pop没有被持有则在方法末尾被直接释放，可以方便的调用这个方法让pop被对象持有
        [pop convenRetain:self];
    }
}

@end
