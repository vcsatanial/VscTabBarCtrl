//
//  VscTabBar.h
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VscTabBar : UITabBar
@property (nonatomic,assign) NSInteger middleButtonIndex;
@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,strong) UIColor *selectColor;
-(void)middleButtonSelected:(BOOL)selected;
@end
