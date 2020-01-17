//
//  CustomAlertViewController.h
//  LWPopupViewController_Example
//
//  Created by 钟志远 on 2020/1/17.
//  Copyright © 2020 zhongzhiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertViewController : UIViewController
@property(nonatomic, copy)void (^clickEventBlock) (NSInteger);
@end

NS_ASSUME_NONNULL_END
