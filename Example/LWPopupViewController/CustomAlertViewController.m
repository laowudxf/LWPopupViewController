//
//  CustomAlertViewController.m
//  LWPopupViewController_Example
//
//  Created by 钟志远 on 2020/1/17.
//  Copyright © 2020 zhongzhiyuan. All rights reserved.
//

#import "CustomAlertViewController.h"
#import "Masonry.h"

@interface CustomAlertViewController ()

@end

@implementation CustomAlertViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear %@", self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear %@", self);
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear %@", self);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear %@", self);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
    }];
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancel:(id)sender {
    if (self.clickEventBlock) {
        NSLog(@"click cancel");
        self.clickEventBlock(0);
    }
}
- (IBAction)ensure:(id)sender {
    
    if (self.clickEventBlock) {
        NSLog(@"click ensure");
        self.clickEventBlock(1);
    }
}

@end
