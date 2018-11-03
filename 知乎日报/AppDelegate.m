//
//  AppDelegate.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/16.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "AppDelegate.h"
//#import "ZJIHomeViewController.h"
//#import "MMDrawerController.h"
//#import "UIViewController+MMDrawerController.h"
//#import "ZJILeftViewController.h"
#import "ZJIContainerViewController.h"
@interface AppDelegate ()

//@property (nonatomic, strong)MMDrawerController *drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    UIViewController *homeViewController = [[ZJIHomeViewController alloc]init];
//    UIViewController *leftViewController = [[ZJILeftViewController alloc]init];
//    UINavigationController *homeNavigationController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
//    UINavigationController *leftNavigationController = [[UINavigationController alloc]initWithRootViewController:leftViewController];
//    self.window.rootViewController = homeNavigationController;
    
//    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:homeNavigationController leftDrawerViewController:leftNavigationController];
//
//    //设置打开/关闭抽起的手势
//    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
//    self.drawerController.openDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
//    //设置左右两边抽起显示的多少
//    self.drawerController.maximumLeftDrawerWidth = 220.0;
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [self.window setRootViewController:self.drawerController];
    //self.window.rootViewController = rootVCLeft;
    //侧拉门的宽度
//    [rootVCLeft setMaximumLeftDrawerWidth:300];
//    //设置侧拉门开与关的动画
//    [rootVCLeft setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [rootVCLeft setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //侧开内容展示效果
    //设置向右滑动打开左侧栏
    //[[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeNone];
//    [rootVCLeft setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//        MMDrawerControllerDrawerVisualStateBlock block;
//        //block =
//        if(block){
//            block(drawerController, drawerSide, percentVisible);
//        }
//    }];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    [self setWindow:[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds]];
    [self.window setRootViewController:[[ZJIContainerViewController alloc]init]];
    [self.window makeKeyAndVisible];

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
