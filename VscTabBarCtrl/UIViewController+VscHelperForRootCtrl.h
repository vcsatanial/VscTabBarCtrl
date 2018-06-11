//
//  UIViewController+VscHelperForRootCtrl.h
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/11.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (VscHelperForRootCtrl)
@property (nonatomic,copy) dispatch_block_t viewWillAppearBlock;
@end
