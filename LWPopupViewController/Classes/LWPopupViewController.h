//
//  PopupViewController.h
//  bingbinggou
//
//  Created by phl on 2019/12/26.
//  Copyright © 2019 李上京. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWPopupViewController : UIViewController
@property (nonatomic, strong) UIColor *bgViewColor;
@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic, assign) BOOL shouldDisableBgTap;


-(void)addContentView:(UIView *)view;

-(void)addContentController:(UIViewController *)controller;




/// 把popupViewController加载到ViewController上面
-(void)showWithViewController:(UIViewController *)viewController;

/// 把popupViewController加载到View上面
-(void)showWithView:(UIView *)view;

///隐藏
-(void)hidden;

//若直接add pop.view 如果pop没有强引用 则会立马释放掉，可以调用一下这个方法，便利的添加强引用
-(void)convenRetain:(NSObject *)obj;
@end

NS_ASSUME_NONNULL_END
