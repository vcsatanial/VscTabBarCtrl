//
//  VscTabBarCtrl.h
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VscTabBarModel.h"

@interface VscTabBarCtrl : UITabBarController
/**
 通过TabBarModel创建相应视图,具体创建方法可以参考VscTabBarModel.h
 */
@property (nonatomic,copy) NSArray <VscTabBarModel *>*sourceCtrls;
/**
 是否允许点击的block(同tabBarController的代理方法,修改了参数变成了Index)
 */
@property (nonatomic,copy) BOOL (^willChangeToTab)(__weak VscTabBarCtrl *tabCtrl,NSInteger index);
/**
 已经点击切换tab的block(同tabBarController的代理方法,修改了参数变成了Index)
 */
@property (nonatomic,copy) void (^didClickTab)(__weak VscTabBarCtrl *tabCtrl,NSInteger index);
/**
 当前的视图(根据设定返回,有可能是navigationController)
 */
@property (nonatomic,weak,readonly) UIViewController *curCtrl;
/**
 是否展示底部TabBar
 */
@property (nonatomic,assign) BOOL displayBottomTabBar;
/**
 初始化方法(直接使用init会设定默认的index)

 @param index 标识为哪一个位置上使用超过边界的效果
 */
-(instancetype)initWithMiddleIndex:(NSInteger)index;

/**
 如果需要更改默认选中视图,请使用此方法
 @param defaultIndex 默认选中Index
 */
-(void)setSourceCtrls:(NSArray<VscTabBarModel *> *)sourceCtrls defaultIndex:(NSInteger)defaultIndex;

/**
 如果重写了delegate的指向,可以在-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;方法中调用下面的方法,保证UI效果与原版一致
 */
-(void)vsc_tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
/**
 是否展示底部TabBar

 @param displayBottomTabBar 展示与否
 @param animate 是否有动画效果
 */
-(void)setDisplayBottomTabBar:(BOOL)displayBottomTabBar animate:(BOOL)animate;
@end
