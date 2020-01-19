//
//  LWPopupView.h
//  LWPopupViewController
//
//  Created by 钟志远 on 2020/1/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWPopupView : UIView
@property (nonatomic, copy) void(^willMoveToSuperViewBlock)(UIView*);
@end

NS_ASSUME_NONNULL_END
