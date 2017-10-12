//
//  ViewController.m
//  testprocess
//
//  Created by Chin on 17/5/31.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import "ViewController.h"
#import "testview.h"
#import "QTimeLine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    QTimeLine * tl = [[QTimeLine alloc]initWithFrame:CGRectMake(0, 100, 700, 60)];
    
    [self.view addSubview:tl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
