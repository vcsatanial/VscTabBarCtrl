//
//  VscTabBarCtrl.m
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import "VscTabBarCtrl.h"
#import "VscTabBar.h"

@interface VscTabBarCtrl ()<UITabBarControllerDelegate>
@property (nonatomic,assign) NSInteger middleIndex;
@property (nonatomic,strong) VscTabBar *myTabBar;
@end

@implementation VscTabBarCtrl
-(VscTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[VscTabBar alloc] init];
    }
    return _myTabBar;
}
-(UIViewController *)curCtrl{
    return self.viewControllers[self.selectedIndex];
}
-(instancetype)initWithMiddleIndex:(NSInteger)index{
    if (self = [super init]) {
        _middleIndex = index;
    }
    return self;
}
-(instancetype)init{
    return [self initWithMiddleIndex:-1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.delegate) {
        self.delegate = self;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSourceCtrls:(NSArray<VscTabBarModel *> *)sourceCtrls{
    [self setSourceCtrls:sourceCtrls defaultIndex:0];
}
-(void)setSourceCtrls:(NSArray <VscTabBarModel *>*)sourceCtrls defaultIndex:(NSInteger)defaultIndex{
    NSInteger allCount = sourceCtrls.count;
    if (allCount % 2 == 1 && self.middleIndex == -1) {
        self.middleIndex = (allCount - 1) / 2;
    }
    self.myTabBar.middleButtonIndex = self.middleIndex;
    NSInteger index = 0;
    NSMutableArray *muArray = @[].mutableCopy;
    for (VscTabBarModel *model in sourceCtrls) {
        Class myClass = NSClassFromString(model.pro_ctrlClass);
        if (myClass) {
            UIViewController *ctrl = [[myClass alloc] init];
            ctrl.tabBarItem.image = [model.pro_norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            ctrl.tabBarItem.selectedImage = [model.pro_selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            ctrl.tabBarItem.title = model.pro_ctrlTitle;
            if (model.pro_titleSelColor) {
                [ctrl.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:model.pro_titleNorColor} forState:0];
            }
            if (model.pro_titleNorColor) {
                [ctrl.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:model.pro_titleSelColor} forState:UIControlStateSelected];
            }
            if (model.pro_noNavigationCtrl) {
                [muArray addObject:ctrl];
            }else{
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
                [muArray addObject:nav];
            }
        }else{
            NSAssert(NO, @"填写的Class并未发现相当的Controller,请检查后重新输入");
        }
        if (index == self.middleIndex) {
            self.myTabBar.normalColor = model.pro_titleNorColor;
            self.myTabBar.selectColor = model.pro_titleSelColor;
        }
        index ++;
    }
    self.viewControllers = muArray;
    [self setValue:self.myTabBar forKey:@"tabBar"];
    NSInteger otherIndex = 0;
    if (defaultIndex == 0) {
        otherIndex = self.viewControllers.count - 1;
    }
    self.selectedIndex = otherIndex;
    self.selectedIndex = defaultIndex;
}
-(void)setDisplayBottomTabBar:(BOOL)displayBottomTabBar{
    _displayBottomTabBar = displayBottomTabBar;
    [self myTabBarDisplay:displayBottomTabBar];
}
-(void)setDisplayBottomTabBar:(BOOL)displayBottomTabBar animate:(BOOL)animate{
    if (animate) {
        
    }else{
        self.displayBottomTabBar = displayBottomTabBar;
    }
}
-(void)myTabBarDisplay:(BOOL)display{
    if (display) {
        self.myTabBar.hidden = NO;
    }else{
        self.myTabBar.hidden = YES;
    }
}
#pragma mark - TabBarController Delegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [self vsc_tabBarController:tabBarController didSelectViewController:viewController];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (self.willChangeToTab) {
        NSInteger index = [self.viewControllers indexOfObject:viewController];
        return self.willChangeToTab(self,index);
    }
    return YES;
}
#pragma mark addedMethod
-(void)vsc_tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    [self.myTabBar middleButtonSelected:(index == _middleIndex)];
    if (self.didClickTab) {
        self.didClickTab(self,index);
    }
}
@end
