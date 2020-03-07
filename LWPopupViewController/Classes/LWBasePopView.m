//
//  LWBasePopView.m
//  bingbinggou
//
//  Created by 李上京 on 2020/1/20.
//  Copyright © 2020 李上京. All rights reserved.
//

#import "LWBasePopView.h"
#import "LWPopupViewController.h"


@implementation LWBasePopView

-(void)show {
    [self showInView:[UIApplication sharedApplication].keyWindow];
    

}

-(void)showInView:(UIView *)view {
    LWPopupViewController *v = [LWPopupViewController new];
    [self.popupViewController addContentView:self];
    [self.popupViewController showWithView:view];
    [self.popupViewController convenRetain:[UIApplication sharedApplication]];
    self.hiddenComplete?self.popupViewController.dismissBlock=self.hiddenComplete:nil;
    
}

-(void)setHiddenComplete:(void (^)(void))hiddenComplete {
    _hiddenComplete = hiddenComplete;
    self.popupViewController.dismissBlock = hiddenComplete;
}

-(void)showInViewController:(UIViewController *)viewcontroller {
    
    self.popupViewController = [LWPopupViewController new];
    [self.popupViewController addContentView:self];
    [self.popupViewController showWithViewController:viewcontroller];
}

-(void)hidden{
    [self.popupViewController hidden];
}

//-(void)hidden:(void(^)(void))completeBlock {
//    [self.popupViewController hidden:completeBlock];
//    self.popupViewController.dismissBlock = ^{
//        completeBlock();
//    };
//}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
