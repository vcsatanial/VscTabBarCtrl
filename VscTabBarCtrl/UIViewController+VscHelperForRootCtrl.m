//
//  UIViewController+VscHelperForRootCtrl.m
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/11.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import "UIViewController+VscHelperForRootCtrl.h"
#import <objc/runtime.h>

static char char_vwaBlock;
@implementation UIViewController (VscHelperForRootCtrl)
+(void)load{
    Method sysMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method cusMethod = class_getInstanceMethod([self class], @selector(vsc_viewWillAppear:));
    method_exchangeImplementations(sysMethod, cusMethod);
}
-(void)vsc_viewWillAppear:(BOOL)animated{
    if (self.viewWillAppearBlock) {
        self.viewWillAppearBlock();
    }
    [self vsc_viewWillAppear:animated];
}
-(void)setViewWillAppearBlock:(dispatch_block_t)viewWillAppearBlock{
    objc_setAssociatedObject(self, &char_vwaBlock, viewWillAppearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(dispatch_block_t)viewWillAppearBlock{
    return objc_getAssociatedObject(self, &char_vwaBlock);
}
@end
