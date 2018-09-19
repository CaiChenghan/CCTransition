//
//  CCTestTransitionAnimator.m
//  CCTransition_Example
//
//  Created by 蔡成汉 on 2018/9/19.
//  Copyright © 2018年 1178752402@qq.com. All rights reserved.
//

#import "CCTestTransitionAnimator.h"
#import "CCViewController.h"
#import "CCTestViewController.h"

@implementation CCTestTransitionAnimator

- (void)setToTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    CCViewController *fromController = (CCViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CCTestViewController *toController = (CCTestViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    
    UIView *snapshotView = [fromController.btn snapshotViewAfterScreenUpdates:YES];
    snapshotView.frame = [fromController.btn convertRect:fromController.btn.bounds toView:containerView];
    
    [containerView addSubview:snapshotView];
    [containerView insertSubview:toController.view belowSubview:snapshotView];
    
    // 执行动画
    [toController.view setNeedsLayout];
    [toController.view layoutIfNeeded];
    fromController.view.alpha = 1.0;
    toController.view.alpha = 0.0;
    fromController.tabBarController.tabBar.hidden = YES;
    [UIView animateWithDuration:self.duration animations:^{
        fromController.view.alpha = 0.0;
        snapshotView.frame = [toController.testBtn convertRect:toController.testBtn.bounds toView:containerView];
    } completion:^(BOOL finished) {
        snapshotView.hidden = YES;
        [snapshotView removeFromSuperview];
        fromController.view.alpha = 0.0;
        toController.view.alpha = 1.0;
        [transitionContext completeTransition:YES];
    }];
}

- (void)setBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    CCTestViewController *fromController = (CCTestViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CCViewController *toController = (CCViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapshotView = [fromController.testBtn snapshotViewAfterScreenUpdates:YES];
    snapshotView.frame = [fromController.testBtn convertRect:fromController.testBtn.bounds toView:containerView];
    
    [containerView addSubview:snapshotView];
    [containerView insertSubview:toController.view belowSubview:snapshotView];
    
    // 执行动画
    fromController.view.alpha = 1.0;
    toController.view.alpha = 0.0;
    [UIView animateWithDuration:self.duration animations:^{
        fromController.view.alpha = 0.0;
        toController.view.alpha = 1.0;
        snapshotView.frame = [toController.btn convertRect:toController.btn.bounds toView:containerView];
    } completion:^(BOOL finished) {
        snapshotView.hidden = YES;
        [snapshotView removeFromSuperview];
        fromController.view.alpha = 0.0;
        toController.view.alpha = 1.0;
        [transitionContext completeTransition:YES];
    }];
}

@end
