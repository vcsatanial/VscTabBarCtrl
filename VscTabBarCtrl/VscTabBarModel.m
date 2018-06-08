//
//  VscTabBarModel.m
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import "VscTabBarModel.h"

@implementation VscTabBarModel
-(instancetype)init{
    if (self = [super init]) {

    }
    return self;
}
-(VscTabBarModel *(^)(NSString *))ctrlTitle{
    return ^(NSString *str){
        self.pro_ctrlTitle = str;
        return self;
    };
}
-(VscTabBarModel *(^)(UIColor *))normalColor{
    return ^(UIColor *color){
        self.pro_titleNorColor = color;
        return self;
    };
}
-(VscTabBarModel *(^)(UIColor *))selectColor{
    return ^(UIColor *color){
        self.pro_titleSelColor = color;
        return self;
    };
}
-(VscTabBarModel *(^)(UIImage *))normalImage{
    return ^(UIImage *image){
        self.pro_norImage = image;
        return self;
    };
}
-(VscTabBarModel *(^)(UIImage *))selectImage{
    return ^(UIImage *image){
        self.pro_norImage = image;
        return self;
    };
}
-(VscTabBarModel *(^)(NSString *))normalImageName{
    return ^(NSString *str){
        self.pro_norImage = [UIImage imageNamed:str];
        return self;
    };
}
-(VscTabBarModel *(^)(NSString *))selectImageName{
    return ^(NSString *str){
        self.pro_selImage = [UIImage imageNamed:str];
        return self;
    };
}
-(VscTabBarModel *)doNotUseNavigationCtrl{
    self.pro_noNavigationCtrl = YES;
    return self;
}
@end
VscTabBarModel *vscTabCtrlCreate(NSString *ctrlName){
    VscTabBarModel *model = [[VscTabBarModel alloc] init];
    model.pro_ctrlClass = ctrlName;
    return model;
}
