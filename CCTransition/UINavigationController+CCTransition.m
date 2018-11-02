//
//  UINavigationController+CCTransition.m
//  CCTransition_Example
//
//  Created by 蔡成汉 on 2018/9/19.
//  Copyright © 2018年 1178752402@qq.com. All rights reserved.
//

#import "UINavigationController+CCTransition.h"
#import "UIViewController+CCTransition.h"
#import <objc/runtime.h>

@implementation UINavigationController (CCTransition)

+ (void)load {
    [self swizzlePresentController];
}

+ (void)swizzlePresentController {
    SEL originSelector = @selector(pushViewController:animated:);
    SEL swizzledSelector = @selector(_cc_pushViewController:animated:);
    Method originMethod = class_getInstanceMethod([self class], originSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    BOOL success = class_addMethod([self class], originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

- (void)_cc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.transitionAnimator) {
        self.delegate = viewController.transitionAnimator;
    }
    [self _cc_pushViewController:viewController animated:animated];
}

@end
