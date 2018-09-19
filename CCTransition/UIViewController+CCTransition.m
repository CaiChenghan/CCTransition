//
//  UIViewController+CCTransition.m
//  CCTransition_Example
//
//  Created by 蔡成汉 on 2018/9/19.
//  Copyright © 2018年 1178752402@qq.com. All rights reserved.
//

#import "UIViewController+CCTransition.h"
#import <objc/runtime.h>

static char CCTransitionAnimatorKEY;

@implementation UIViewController (CCTransition)

+ (void)load {
    [self swizzlePresentController];
}

+ (void)swizzlePresentController {
    SEL originSelector = @selector(presentViewController:animated:completion:);
    SEL swizzledSelector = @selector(_presentViewController:animated:completion:);
    Method originMethod = class_getInstanceMethod([self class], originSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    BOOL success = class_addMethod([self class], originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

- (void)_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (viewControllerToPresent.transitionAnimator) {
        viewControllerToPresent.transitioningDelegate = viewControllerToPresent.transitionAnimator;
    }
    [self _presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)setTransitionAnimator:(CCTransitionAnimator *)transitionAnimator {
    objc_setAssociatedObject(self, &CCTransitionAnimatorKEY, transitionAnimator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CCTransitionAnimator *)transitionAnimator {
    return objc_getAssociatedObject(self, &CCTransitionAnimatorKEY);
}

@end
