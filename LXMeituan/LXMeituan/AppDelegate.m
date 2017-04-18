//
//  AppDelegate.m
//  LXMeituan
//
//  Created by Noki on 2017/4/6.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "AppDelegate.h"
#import "LXHomeViewController.h"
#import "LXMineVc.h"
#import "LXMerchantVc.h"
#import "LXMoreVc.h"
#import "LXHomeServiceVc.h"
#import "LXNavigationVc.h"
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()<CLLocationManagerDelegate>
@property(nonatomic,strong)UITabBarController *tabbarVc;
@property(nonatomic,strong)CLLocationManager * locationManager;
@end

@implementation AppDelegate
-(void)setUpLocationManager{
    self.latitude=LATITUDE_DEFAULT;
    self.longitude=LONGITUDE_DEFAULT;
    
    _locationManager=[[CLLocationManager alloc]init];
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=200;
        
        if (IOS_VERSION>=8.0) {
            [self.locationManager requestAlwaysAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }else{
        NSLog(@"定位失败,未开启定位功能");
    }

    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setUpTabbar];
    [self setUpLocationManager];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=self.tabbarVc;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)setUpTabbar{
    UITabBarController *tabbarVc=[[UITabBarController alloc]init];
    self.tabbarVc=tabbarVc;
    //团购
    LXHomeViewController *homeVc=[[LXHomeViewController alloc]init];
    [self setOneChildController:homeVc image:@"icon_tabbar_homepage" selImage:@"icon_tabbar_homepage_selected" title:@"团购"];
    //上门
    LXHomeServiceVc *homeServiceVc=[[LXHomeServiceVc alloc]init];
    [self setOneChildController:homeServiceVc image:@"icon_tabbar_onsite" selImage:@"icon_tabbar_onsite_selected" title:@"上门"];
    //商家
    LXMerchantVc *merchantVc=[[LXMerchantVc alloc]init];
    [self setOneChildController:merchantVc image:@"icon_tabbar_merchant_normal" selImage:@"icon_tabbar_merchant_selected" title:@"商家"];
    //我的
    LXMineVc *mineVc=[[LXMineVc alloc]init];
    [self setOneChildController:mineVc image:@"icon_tabbar_mine" selImage:@"icon_tabbar_mine_selected" title:@"我的"];
    //更多
    LXMoreVc *moreVc=[[LXMoreVc alloc]init];
    [self setOneChildController:moreVc image:@"icon_tabbar_misc"selImage:@"icon_tabbar_misc_selected" title:@"更多"];
    NSDictionary *dic=[NSDictionary dictionaryWithObject:LXGRB(54, 185, 175) forKey:NSForegroundColorAttributeName ];
    [[UITabBarItem appearance ]setTitleTextAttributes:dic forState:UIControlStateSelected];

}
-(void)setOneChildController:(UIViewController *)vc image:(NSString *)imageName selImage:(NSString *)selImageName title:(NSString *)title{
    vc.title=title;
   
    vc.tabBarItem.image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    LXNavigationVc *navigationVc=[[LXNavigationVc alloc]initWithRootViewController:vc];
    [self.tabbarVc addChildViewController:navigationVc];
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
//locationManager delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * location=[locations lastObject];
    self.latitude=location.coordinate.latitude;
    self.longitude=location.coordinate.longitude;
    
}

@end
