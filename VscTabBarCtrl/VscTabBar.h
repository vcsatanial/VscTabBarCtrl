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
@property (nonatomic,assign,readonly) CGFloat realHeight;
@property (nonatomic,assign) CGSize btnSize;
@property (nonatomic,assign) CGFloat btnY;
@property (nonatomic,assign) BOOL visible;
-(void)middleButtonSelected:(BOOL)selected;
@end
