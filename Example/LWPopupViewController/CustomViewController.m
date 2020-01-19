//
//  CustomViewController.m
//  LWPopupViewController_Example
//
//  Created by 钟志远 on 2020/1/19.
//  Copyright © 2020 zhongzhiyuan. All rights reserved.
//

#import "CustomViewController.h"
#import "Masonry.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *b = [UIButton new];
    [self.view addSubview:b];
    [b addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    b.backgroundColor = [UIColor redColor];
    [b setTitle:@"next" forState:UIControlStateNormal];
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(self.view);
    }];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"我的页面";
}

-(void)clickBtn {
    [self.navigationController pushViewController:[CustomViewController new] animated:true];
}

-(void)dealloc {
    NSLog(@"%s", __func__);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
