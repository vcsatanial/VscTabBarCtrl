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
        _useAutoDisplayTabBarWhenRootCtrl = YES;
    }
    return self;
}
-(instancetype)init{
    return [self initWithMiddleIndex:-314];
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
    if (allCount % 2 == 1 && self.middleIndex == -314) {
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
            __weak typeof(ctrl)wc = ctrl;
            ctrl.viewWillAppearBlock = ^{
                [((VscTabBarCtrl *)wc.tabBarController) setDisplayBottomTabBar:YES animate:YES];
            };
            if (model.pro_titleNorColor) {
                [ctrl.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:model.pro_titleNorColor} forState:0];
            }
            if (model.pro_titleSelColor) {
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
    if (self.middleIndex == defaultIndex) {
        [self.myTabBar middleButtonSelected:YES];
    }
}
-(void)setUseAutoDisplayTabBarWhenRootCtrl:(BOOL)useAutoDisplayTabBarWhenRootCtrl{
    if (useAutoDisplayTabBarWhenRootCtrl) {
        for (UIViewController *vc in self.viewControllers) {
            UIViewController *tempCtrl = vc;
            if ([vc isKindOfClass:[UINavigationController class]]) {
                tempCtrl = ((UINavigationController *)vc).viewControllers[0];
            }
            __weak typeof(tempCtrl)wc = tempCtrl;
            tempCtrl.viewWillAppearBlock = ^{
                [((VscTabBarCtrl *)wc.tabBarController) setDisplayBottomTabBar:YES animate:YES];
            };
        }
    }else{
        for (UIViewController *vc in self.viewControllers) {
            UIViewController *tempCtrl = vc;
            if ([vc isKindOfClass:[UINavigationController class]]) {
                tempCtrl = ((UINavigationController *)vc).viewControllers[0];
            }
            tempCtrl.viewWillAppearBlock = nil;
        }
    }
}
-(void)setDisplayBottomTabBar:(BOOL)displayBottomTabBar{
    [self setDisplayBottomTabBar:displayBottomTabBar animate:NO];
}
-(void)setMiddleSize:(CGSize)size{
    self.myTabBar.btnSize = size;
}
-(void)setMiddleSize:(CGSize)size orighY:(CGFloat)y{
    self.myTabBar.btnSize = size;
    self.myTabBar.btnY = y;
}
-(void)setDisplayBottomTabBar:(BOOL)displayBottomTabBar animate:(BOOL)animate{
    if (self.myTabBar.visible != displayBottomTabBar) {
        self.myTabBar.visible = displayBottomTabBar;
        CGFloat moveY = 0 + self.myTabBar.realHeight * (displayBottomTabBar ? -1 : 1);
        if (animate) {
            [UIView animateWithDuration:0.25 animations:^{
                [self moveMyTabBarWithY:moveY];
            }];
        }else{
            [self moveMyTabBarWithY:moveY];
        }
    }
}
-(void)moveMyTabBarWithY:(CGFloat)moveY{
    CGRect frame = self.myTabBar.frame;
    frame.origin.y += moveY;
    self.myTabBar.frame = frame;
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
