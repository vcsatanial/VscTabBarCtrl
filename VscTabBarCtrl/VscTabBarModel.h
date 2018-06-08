//
//  VscTabBarModel.h
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//链式传值比属性传值更为方便,建议使用链式传值,更具体的方法可以参考Demo中的Appdelegate里的创建方法
//Demo地址:  https://github.com/vcsatanial/VscTabBarCtrl

@interface VscTabBarModel : NSObject
@property (nonatomic,copy) NSString *pro_ctrlClass;
@property (nonatomic,copy) NSString *pro_ctrlTitle;
@property (nonatomic,strong) UIColor *pro_titleNorColor;
@property (nonatomic,strong) UIColor *pro_titleSelColor;
@property (nonatomic,strong) UIImage *pro_norImage;
@property (nonatomic,strong) UIImage *pro_selImage;
@property (nonatomic,assign) BOOL pro_noNavigationCtrl;
-(VscTabBarModel *(^)(NSString *))ctrlTitle;
-(VscTabBarModel *(^)(UIColor *))normalColor;
-(VscTabBarModel *(^)(UIColor *))selectColor;
-(VscTabBarModel *(^)(UIImage *))normalImage;
-(VscTabBarModel *(^)(UIImage *))selectImage;
-(VscTabBarModel *(^)(NSString *))normalImageName;
-(VscTabBarModel *(^)(NSString *))selectImageName;
-(VscTabBarModel *)doNotUseNavigationCtrl;
@end
VscTabBarModel *vscTabCtrlCreate(NSString *ctrlName);
