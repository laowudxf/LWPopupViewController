//
//  LWPopupAnimationSheetStyle.m
//  AFNetworking
//
//  Created by 钟志远 on 2020/2/9.
//

#import "LWPopupAnimationSheetStyle.h"
#import "LWPopupViewController.h"

@implementation LWPopupAnimationSheetStyle
-(void)setup {
    
    self.showAnimation = ^(LWPopupViewController * _Nonnull pop, void(^completeBlock)(BOOL)) {
        pop.view.alpha = 0;
        [pop.contenteView setNeedsUpdateConstraints];
        [pop.contenteView updateConstraints];
        NSLog(@"%@",pop.contenteView);
        CGRect contentViewRect = pop.contenteView.frame;
        pop.contenteView.transform = CGAffineTransformMakeTranslation(0, contentViewRect.size.height);
        [UIView animateWithDuration:0.2 animations:^{
            pop.view.alpha = 1;
            pop.contenteView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            if (completeBlock) {
                completeBlock(finished);
            }
        }];
    };
    
    self.hiddenAnimation = ^(LWPopupViewController * _Nonnull pop, void(^completeBlock)(BOOL)) {
        CGRect contentViewRect = pop.contenteView.frame;
        [UIView animateWithDuration:0.2 animations:^{
            pop.view.alpha = 0;
            pop.contenteView.transform = CGAffineTransformMakeTranslation(0, contentViewRect.size.height);
        } completion:^(BOOL finished) {
            if (completeBlock) {
                completeBlock(finished);
            }
        }];
    };
}
@end
