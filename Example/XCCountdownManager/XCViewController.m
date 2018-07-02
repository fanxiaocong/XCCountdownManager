//
//  XCViewController.m
//  XCCountdownManager
//
//  Created by fanxiaocong on 06/29/2018.
//  Copyright (c) 2018 fanxiaocong. All rights reserved.
//

#import "XCViewController.h"
#import "XCTTTViewController.h"

@interface XCViewController ()

@end

@implementation XCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    XCTTTViewController *vc = [[XCTTTViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
