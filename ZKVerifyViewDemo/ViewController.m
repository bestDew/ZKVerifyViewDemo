//
//  ViewController.m
//  ZKVerifyViewDemo
//
//  Created by bestdew on 2018/11/22.
//  Copyright © 2018 bestdew. All rights reserved.
//

#import "ViewController.h"
#import "ZKVerifyAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, 50.f)];
        label.center = self.view.center;
        label.font = [UIFont boldSystemFontOfSize:20.f];
        label.text = @"点我，点我！";
        label.textAlignment = NSTextAlignmentCenter;
        label;
    })];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZKVerifyAlertView *verifyView = [[ZKVerifyAlertView alloc] initWithMaximumVerifyNumber:3 results:^(ZKVerifyState state) {
        NSLog(@"%zd", state);
    }];
    [verifyView show];
}

@end
