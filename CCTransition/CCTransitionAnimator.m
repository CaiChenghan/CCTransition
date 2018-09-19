//
//  CCTransitionAnimator.m
//  CCTransition_Example
//
//  Created by 蔡成汉 on 2018/9/19.
//  Copyright © 2018年 1178752402@qq.com. All rights reserved.
//

#import "CCTransitionAnimator.h"
#import "UIViewController+CCTransition.h"

@interface _CCTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, copy) void(^config)(id<UIViewControllerContextTransitioning>transitionContext);

- (instancetype)initWithDuration:(NSTimeInterval)duration animationBlock:(void(^)(id<UIViewControllerContextTransitioning>transitionContext))config;

@end

@implementation _CCTransitionAnimator

- (instancetype)initWithDuration:(NSTimeInterval)duration animationBlock:(void (^)(id<UIViewControllerContextTransitioning>))config {
    self = [super init];
    if (self) {
        _duration = duration;
        _config = config;
    }
    return self;
}

- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.config) {
        self.config(transitionContext);
    }
}

@end


@interface CCTransitionAnimator ()

@property (nonatomic, strong) _CCTransitionAnimator *toTransition;
@property (nonatomic, strong) _CCTransitionAnimator *backTransition;

@property (nonatomic, weak) id<UINavigationControllerDelegate> _navigationControllerDelegate;

@end

@implementation CCTransitionAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.duration = 0.45;
    }
    return self;
}

- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    self.toTransition.duration = self.backTransition.duration = _duration;
}

- (_CCTransitionAnimator *)toTransition {
    if (_toTransition == nil) {
        __weak typeof(self) weakSelf = self;
        _toTransition = [[_CCTransitionAnimator alloc]initWithDuration:self.duration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [weakSelf setToTransitionAnimation:transitionContext];
        }];
    }
    return _toTransition;
}

- (_CCTransitionAnimator *)backTransition {
    if (_backTransition == nil) {
        __weak typeof(self) weakSelf = self;
        _backTransition = [[_CCTransitionAnimator alloc]initWithDuration:self.duration animationBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            [weakSelf setBackTransitionAnimation:transitionContext];
        }];
    }
    return _backTransition;
}

// 子类重写方法，可实现自定义转场动画
- (void)setToTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    // do no thing
}

- (void)setBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    // do no thing
}

// 设置导航代理，当转场控制器需要设置导航代理的时候需如此设置
- (void)setNavigationControllerDelegate:(id)navigationControllerDelegate {
    self._navigationControllerDelegate = navigationControllerDelegate;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return presented.transitionAnimator.toTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return dismissed.transitionAnimator.backTransition;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        if (toVC.transitionAnimator) {
            return toVC.transitionAnimator.toTransition;
        } else {
            return nil;
        }
    } else {
        if (fromVC.transitionAnimator) {
            return fromVC.transitionAnimator.backTransition;
        } else {
            return nil;
        }
    }
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self._navigationControllerDelegate && [self._navigationControllerDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self._navigationControllerDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self._navigationControllerDelegate && [self._navigationControllerDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self._navigationControllerDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
    if (self._navigationControllerDelegate && [self._navigationControllerDelegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        return [self._navigationControllerDelegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
    if (self._navigationControllerDelegate && [self._navigationControllerDelegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)]) {
        return [self._navigationControllerDelegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationPortrait;
}

@end
