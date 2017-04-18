//
//  LXNavigationVc.m
//  LXMeituan
//
//  Created by Noki on 2017/4/7.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXNavigationVc.h"

@interface LXNavigationVc ()

@end

@implementation LXNavigationVc
+(void)load{
  [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                      forBarMetrics:UIBarMetricsDefault];
    UINavigationBar * navigationBar=[UINavigationBar appearance];
    NSDictionary * att=@{NSFontAttributeName:LXFont(17),NSForegroundColorAttributeName:[UIColor blackColor]};
    navigationBar.translucent = NO;
    [navigationBar setTitleTextAttributes:att];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count!=0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}


@end
