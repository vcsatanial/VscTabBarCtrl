//
//  RedCtrl.m
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import "RedCtrl.h"
#import "VscTabBarCtrl.h"

@interface RedCtrl ()

@end

@implementation RedCtrl

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [((VscTabBarCtrl *)self.tabBarController) setDisplayBottomTabBar:YES animate:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UIButton *enter = [[UIButton alloc] initWithFrame:CGRectMake(50, 350, 50, 50)];
    enter.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:enter];
    [enter addTarget:self action:@selector(enterSubCtrl) forControlEvents:64];
    
    UIButton *enter2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 350, 50, 50)];
    enter2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:enter2];
    [enter2 addTarget:self action:@selector(enterSubCtrl2) forControlEvents:64];
}
-(void)enterSubCtrl{
    NSString *className = @"RedSubCtrl";
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)enterSubCtrl2{
    NSString *className = @"RedSubCtrl";
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    [((VscTabBarCtrl *)self.tabBarController) setDisplayBottomTabBar:NO animate:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
