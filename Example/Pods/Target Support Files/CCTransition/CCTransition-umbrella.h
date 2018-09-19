#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CCTransition.h"
#import "CCTransitionAnimator.h"
#import "UINavigationController+CCTransition.h"
#import "UIViewController+CCTransition.h"

FOUNDATION_EXPORT double CCTransitionVersionNumber;
FOUNDATION_EXPORT const unsigned char CCTransitionVersionString[];

