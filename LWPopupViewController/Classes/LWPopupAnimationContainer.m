//
//  LWPopupAnimationContainer.m
//  LWPopupViewController
//
//  Created by 钟志远 on 2020/2/9.
//

#import "LWPopupAnimationContainer.h"
#import "LWPopupViewController.h"

@implementation LWPopupAnimationContainer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.showAnimation = ^(LWPopupViewController * _Nonnull pop, void(^completeBlock)(BOOL)) {
        
        pop.view.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
           pop.view.alpha = 1;
        } completion:^(BOOL finished) {
            if (completeBlock) {
                completeBlock(finished);
            }
        }];
    };
    
    self.hiddenAnimation = ^(LWPopupViewController * _Nonnull pop, void(^completeBlock)(BOOL)) {
        [UIView animateWithDuration:0.2 animations:^{
            pop.view.alpha = 0;
        } completion:^(BOOL finished) {
            if (completeBlock) {
                completeBlock(finished);
            }
        }];
    };
}

@end
