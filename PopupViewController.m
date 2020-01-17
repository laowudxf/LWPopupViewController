//
//  PopupViewController.m
//  bingbinggou
//
//  Created by phl on 2019/12/26.
//  Copyright © 2019 李上京. All rights reserved.
//

#import "PopupViewController.h"
#import "objc/runtime.h"

#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

@interface PopupViewController ()
@property (nonatomic, weak) NSObject *parentRetainer;
@end

@implementation PopupViewController


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
    return  true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addTargetAction];
    
    // Do any additional setup after loading the view.
}


-(void) setupUI {
    self.view.backgroundColor = self.bgViewColor;
}

-(void)addTargetAction {
    if (self.shouldDisableBgTap) {
        return;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

-(void)showWithViewController:(UIViewController *)viewController {
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self didMoveToParentViewController:viewController];
}


- (void)willMoveToParentViewController:(UIViewController *)parent {
    if (parent) {
        self.view.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.view.alpha = 1;
        }];
    } else {
    }
}

-(void)hidden {
    [self tapAction];
}
-(void)tapAction {
    kWeakSelf(self);
    if (self.parentViewController) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self willMoveToParentViewController:nil];
            [self.view removeFromSuperview];
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
            [self willMoveToParentViewController:nil];
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            if (self.parentRetainer) {
                objc_setAssociatedObject(self.parentRetainer, popupViewControllerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }];
    }
    
}

-(void)addContentView:(UIView *)view {
    [self.view addSubview:view];
//    view.userInteractionEnabled = true;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentAction)];
    [view addGestureRecognizer:tap];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

static char *popupViewControllerKey = "_popupViewController";

-(void)addContentController:(UIViewController *)controller {
    [self addContentView:controller.view];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];

}

-(void)convenRetain:(NSObject *) obj {
    
    objc_setAssociatedObject(obj, popupViewControllerKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.parentRetainer = obj;
}

- (void)tapContentAction {
    
}

-(void)dealloc {
    NSLog(@"%@", self);
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
