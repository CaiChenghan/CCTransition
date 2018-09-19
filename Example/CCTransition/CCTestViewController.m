//
//  CCTestViewController.m
//  CCTransition_Example
//
//  Created by 蔡成汉 on 2018/9/19.
//  Copyright © 2018年 1178752402@qq.com. All rights reserved.
//

#import "CCTestViewController.h"

@interface CCTestViewController ()

@end

@implementation CCTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _testBtn.frame = CGRectMake(0, 100, 300, 400);
    _testBtn.backgroundColor = [UIColor purpleColor];
    [_testBtn addTarget:self action:@selector(doMyTransition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testBtn];
}

- (void)doMyTransition {
    
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
