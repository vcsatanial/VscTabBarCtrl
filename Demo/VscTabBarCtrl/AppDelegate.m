//
//  AppDelegate.m
//  VscTabBarCtrl
//
//  Created by Visac on 2018/6/7.
//  Copyright © 2018年 VincentChou. All rights reserved.
//

#import "AppDelegate.h"
#import "VscTabBarCtrl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    VscTabBarCtrl *tab = [[VscTabBarCtrl alloc] init];
    [tab setSourceCtrls: @[
                           vscTabCtrlCreate(@"RedCtrl")
                           .ctrlTitle(@"红色")
                           .normalColor([UIColor greenColor])
                           .selectColor([UIColor redColor])
                           .normalImageName(@"left")
                           .selectImageName(@"left_h"),
                           
                           vscTabCtrlCreate(@"YellowCtrl")
                           .ctrlTitle(@"黄色")
                           .normalColor([UIColor blueColor])
                           .selectColor([UIColor yellowColor])
                           .normalImageName(@"left2")
                           .selectImageName(@"left2_h"),
                           
                           vscTabCtrlCreate(@"MiddleCtrl")
                           .ctrlTitle(@"中间")
                           .normalColor([UIColor blackColor])
                           .normalImageName(@"middle")
                           .selectImageName(@"middle_h"),
                           
                           vscTabCtrlCreate(@"BlueCtrl")
                           .ctrlTitle(@"绿色")
                           .normalColor([UIColor yellowColor])
                           .selectColor([UIColor blueColor])
                           .normalImageName(@"right2")
                           .selectImageName(@"right2_h"),
                           
                           vscTabCtrlCreate(@"GreenCtrl")
                           .ctrlTitle(@"紫色")
                           .normalColor([UIColor redColor])
                           .selectColor([UIColor greenColor])
                           .normalImageName(@"right")
                           .selectImageName(@"right_h")
                           .doNotUseNavigationCtrl,
                           ]
           defaultIndex:0];
    tab.willChangeToTab = ^BOOL(VscTabBarCtrl *__weak tabCtrl, NSInteger index) {
        if (index == 2) {
            if ([tabCtrl.curCtrl isKindOfClass:[UINavigationController class]]) {
                UIViewController *vc = [[NSClassFromString(@"MiddleCtrl") alloc] init];
                [tabCtrl setDisplayBottomTabBar:NO animate:YES];
                [((UINavigationController *)tabCtrl.curCtrl) pushViewController:vc animated:YES];
            }
            return NO;
        }
        return YES;
    };
    self.window.rootViewController = tab;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
