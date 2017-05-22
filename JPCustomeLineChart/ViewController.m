//
//  ViewController.m
//  JPCustomeLineChart
//
//  Created by 鞠鹏 on 2017/5/22.
//  Copyright © 2017年 JuPeng. All rights reserved.
//

#import "ViewController.h"
#import "BrokenLineView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *pointsYArr = @[@"6",@"12",@"10",@"11",@"8",@"15",@"25"];
    
    NSArray *YAxisArr = @[@"5",@"10",@"15",@"20",@"25"];
    NSArray *XAxisArr = @[@"8",@"9",@"10",@"11",@"12",@"13",@"14"];
    
    NSMutableArray *pointsArr = [NSMutableArray array];
    for (NSInteger i = 0; i < pointsYArr.count; i ++) {
        NSDictionary *pointDict = @{@"x":XAxisArr[i],
                                    @"y":pointsYArr[i]};
        [pointsArr addObject:pointDict];
    }
    
    
    BrokenLineView *brokenLineView = [[BrokenLineView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width / 1.6) XAxisArr:XAxisArr YAxisArr:YAxisArr pointsArr:pointsArr];
    
    [self.view addSubview:brokenLineView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
