//
//  LWBasePopView.h
//  bingbinggou
//
//  Created by 李上京 on 2020/1/20.
//  Copyright © 2020 李上京. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LWPopupViewController;

@interface LWBasePopView : UIView

@property (nonatomic, weak) LWPopupViewController *popupViewController;

-(void)show;
-(void)showInView:(UIView *)view;
-(void)showInViewController:(UIViewController *)viewcontroller;

-(void)hidden;

@end

NS_ASSUME_NONNULL_END
