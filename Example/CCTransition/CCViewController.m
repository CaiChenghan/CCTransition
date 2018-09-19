//
//  CCViewController.m
//  CCTransition
//
//  Created by 1178752402@qq.com on 09/19/2018.
//  Copyright (c) 2018 1178752402@qq.com. All rights reserved.
//

#import "CCViewController.h"
#import "CCTransition.h"
#import "CCTestViewController.h"
#import "CCTestTransitionAnimator.h"


@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(100, 200, 100, 200);
    _btn.backgroundColor = [UIColor purpleColor];
    [_btn addTarget:self action:@selector(doMyTransition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)doMyTransition {
    CCTestViewController *controller = [[CCTestViewController alloc]init];
    CCTestTransitionAnimator *animator = [[CCTestTransitionAnimator alloc]init];
    animator.duration = 0.5;
    controller.transitionAnimator = animator;
    [self.navigationController pushViewController:controller animated:YES];
}
     
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
