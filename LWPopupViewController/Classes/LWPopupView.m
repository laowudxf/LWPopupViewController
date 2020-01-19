//
//  LWPopupView.m
//  LWPopupViewController
//
//  Created by 钟志远 on 2020/1/19.
//

#import "LWPopupView.h"

@implementation LWPopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (self.willMoveToSuperViewBlock) {
        self.willMoveToSuperViewBlock(newSuperview);
    }
}

@end
