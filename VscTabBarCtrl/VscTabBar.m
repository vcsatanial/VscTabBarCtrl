//
//  VscTabBar.m
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import "VscTabBar.h"

@interface VscTabBar (){
    NSInteger middleIndex;
    UIView *middleView;
    NSMutableArray *myBtns;
}
@property (nonatomic,strong) UIButton *middleButton;
@property (nonatomic,strong) UILabel *middleLabel;
@property (nonatomic,weak) UITabBarController *superCtrl;
@end

@implementation VscTabBar
-(void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    self.visible = !hidden;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.middleButton];
        [self addSubview:self.middleLabel];
        middleIndex = -1;
        _visible = YES;
        myBtns = @[].mutableCopy;
    }
    return self;
}
-(void)setMiddleButtonIndex:(NSInteger)middleButtonIndex{
    middleIndex = middleButtonIndex;
}
-(NSInteger)middleButtonIndex{
    return middleIndex;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _realHeight = self.frame.size.height + 10;
    int index = 0;
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == middleIndex) {
                middleView = btn;
                
                for (UIView *subView in btn.subviews) {
                    subView.hidden = YES;
                }
                UITabBarItem *item = self.superCtrl.viewControllers[middleIndex].tabBarItem;
                self.middleLabel.text = item.title;
                if (self.normalColor) {
                    self.middleLabel.textColor = self.normalColor;
                }
                [self.middleButton setBackgroundImage:item.image forState:0];
                [self.middleButton setBackgroundImage:item.selectedImage forState:UIControlStateHighlighted];
                [self.middleButton setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
                
                CGRect frame;
                frame.size = CGSizeMake(self.middleButton.currentBackgroundImage.size.width, self.middleButton.currentBackgroundImage.size.height);
                frame.origin = CGPointMake(btn.center.x - frame.size.width / 2, - frame.size.height / 2);
                self.middleButton.frame = frame;
                CGFloat height = self.middleLabel.font.lineHeight;
                
                _realHeight = self.frame.size.height + frame.size.height / 2;
                
                CGFloat y = self.frame.size.height - height;
                if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
                    y -= [UIScreen mainScreen].currentMode.size.height == 2436 ? 34 : 0;
                }
                self.middleLabel.frame = CGRectMake(btn.frame.origin.x,y , btn.frame.size.width, height);
            }else{
                [myBtns addObject:btn];
            }
            index ++ ;
        }
    }
}
-(void)middleButtonSelected:(BOOL)selected{
    if (selected) {
        self.middleButton.selected = YES;
        if (self.selectColor) {
            self.middleLabel.textColor = self.selectColor;
        }
    }else{
        self.middleButton.selected = NO;
        if (self.normalColor) {
            self.middleLabel.textColor = self.normalColor;
        }
    }
}
#pragma mark - Change Click Rect
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(self.middleButton.frame, point)) {
        if (point.y < 0) {
            point.y += self.middleButton.frame.size.height / 2;
        }
    }
    return [super hitTest:point withEvent:event];
}
#pragma mark - Getter
-(UITabBarController *)superCtrl{
    if (!_superCtrl) {
        UIResponder *responder = self;
        while (![responder isKindOfClass:[UITabBarController class]]) {
            responder = responder.nextResponder;
        }
        _superCtrl = (UITabBarController *)responder;
    }
    return _superCtrl;
}
-(UIButton *)middleButton{
    if (!_middleLabel) {
        _middleButton = [[UIButton alloc] init];
        _middleButton.adjustsImageWhenHighlighted = NO;
    }
    return _middleButton;
}
-(UILabel *)middleLabel{
    if (!_middleLabel) {
        _middleLabel = [[UILabel alloc] init];
        _middleLabel.font = [UIFont systemFontOfSize:11];
        _middleLabel.textAlignment = 1;
        _middleLabel.textColor = [UIColor grayColor];
    }
    return _middleLabel;
}
@end
