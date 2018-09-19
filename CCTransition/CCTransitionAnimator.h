//
//  CCTransitionAnimator.h
//  CCTransition_Example
//
//  Created by 蔡成汉 on 2018/9/19.
//  Copyright © 2018年 1178752402@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCTransitionAnimator : NSObject<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) NSTimeInterval duration;

// 子类重写方法，可实现自定义转场动画
- (void)setToTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)setBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

// 设置导航代理，当转场控制器需要设置导航代理的时候需如此设置
- (void)setNavigationControllerDelegate:(id)navigationControllerDelegate;

@end

NS_ASSUME_NONNULL_END
