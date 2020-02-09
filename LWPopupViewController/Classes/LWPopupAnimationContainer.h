//
//  LWPopupAnimationContainer.h
//  LWPopupViewController
//
//  Created by 钟志远 on 2020/2/9.
//

#import <Foundation/Foundation.h>
@class LWPopupViewController;

NS_ASSUME_NONNULL_BEGIN
typedef void(^LWAnimationBlock)(LWPopupViewController *, void(^)(BOOL));

@interface LWPopupAnimationContainer : NSObject
@property (nonatomic, assign)LWAnimationBlock showAnimation;
@property (nonatomic, assign)LWAnimationBlock hiddenAnimation;

-(void)setup;
@end

NS_ASSUME_NONNULL_END
