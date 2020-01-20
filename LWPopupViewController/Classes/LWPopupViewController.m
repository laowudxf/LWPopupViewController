//
//  PopupViewController.m
//  bingbinggou
//
//  Created by phl on 2019/12/26.
//  Copyright © 2019 李上京. All rights reserved.
//

#import "LWPopupViewController.h"
#import "objc/runtime.h"
#import <Masonry/Masonry.h>

#import "LWPopupView.h"


#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

@interface LWPopupViewController ()
@property (nonatomic, weak) NSObject *parentRetainer;
@property (nonatomic, strong) NSArray *contentContraint;
@end

@implementation LWPopupViewController

- (void)loadView {
    self.view = [LWPopupView new];
}

-(LWPopupView *)customView {
    return (LWPopupView *)self.view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bgViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    return self;
}


- (BOOL)prefersStatusBarHidden {
    return false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addTargetAction];
    
    // Do any additional setup after loading the view.
    
    kWeakSelf(self)
    [self customView].willMoveToSuperViewBlock = ^(UIView * _Nonnull parent) {
        kStrongSelf(self)
        
        if (parent) {
            self.view.alpha = 0;
            [UIView animateWithDuration:0.2 animations:^{
                self.view.alpha = 1;
                if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
                    [self endAppearanceTransition];
                }
            }];
        } else {
        }
        
    };
}



-(void) setupUI {
    self.view.backgroundColor = self.bgViewColor;
}

-(void)setBgViewColor:(UIColor *)bgViewColor {
    _bgViewColor = bgViewColor;
    self.view.backgroundColor = self.bgViewColor;
}

-(void)addTargetAction {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}


-(void)showWithView:(UIView *)view {
    [view addSubview:self.view];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(void)showWithViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:UINavigationController.class]) {
        [self beginAppearanceTransition:true animated:true];
    }
    [viewController addChildViewController:self];
    
    [self showWithView:viewController.view];
    
    if (self.parentViewController) {
        [self didMoveToParentViewController:viewController];
    }
}


-(void)hidden {
    kWeakSelf(self);
    if (self.parentViewController) {
        if ([self.parentViewController isKindOfClass:UINavigationController.class]) {
            [self beginAppearanceTransition:false animated:true];
        }
        
        [self willMoveToParentViewController:nil];
        [UIView animateWithDuration:0.2 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            if ([self.parentViewController isKindOfClass:UINavigationController.class]) {
                [self endAppearanceTransition];
            }
            [self removeFromParentViewController];
        }];
        return;
    } else if (self.presentingViewController) {
        
        [self dismissViewControllerAnimated:true completion:^{
            kStrongSelf(self);
            if (self.dismissBlock) {
                self.dismissBlock();
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            if (self.parentRetainer) {
                objc_setAssociatedObject(self.parentRetainer, &popupViewControllerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }];
    }
}
-(void)tapAction {
    
    if (self.shouldDisableBgTap) {
        return;
    }
    
    [self hidden];

}

-(void)removeContentContraint {
    if (!self.contentContraint) {
        return;
    }
    
    for (MASConstraint *c  in self.contentContraint) {
        [c uninstall];
    }
}

-(void)addContentView:(UIView *)view {
    [self.view addSubview:view];
//    view.userInteractionEnabled = true;
    
   self.contentContraint = [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

static const int popupViewControllerKey = 0;

-(void)addContentController:(UIViewController *)controller {
    [self addContentView:controller.view];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];

}

-(void)convenRetain:(NSObject *) obj {
    
    objc_setAssociatedObject(obj, &popupViewControllerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.parentRetainer = obj;
}

-(void)dealloc {
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
