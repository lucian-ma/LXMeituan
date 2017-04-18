//
//  LXShopViewVc.m
//  LXMeituan
//
//  Created by Noki on 2017/4/11.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXShopViewVc.h"

@interface LXShopViewVc ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * _tableView;
    UIActivityIndicatorView * _activityView;
}

@end

@implementation LXShopViewVc
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavi];
    [self initViews];
}
-(void)setNavi{
    self.title=@"团购详情";
    
    UIButton * shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_normal"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_highlighted"] forState:UIControlStateHighlighted];
    shareBtn.frame=CGRectMake(0, 0, 22, 22);
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    
    UIButton * collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [collectBtn setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"icon_collect_highlighted"] forState:UIControlStateHighlighted];
    collectBtn.frame=CGRectMake(0, 0, 22, 22);

    [collectBtn addTarget:shareBtn action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithCustomView:collectBtn];
    
    self.navigationItem.rightBarButtonItems=@[item1,item2];
}
-(void)initViews{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, LXScreen_height-64)style:UITableViewStyleGrouped];
//    _tableView.dataSource=self;
//    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    _activityView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(LXScreen_width/2-15, LXScreen_height/2-15, 30, 30)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped=YES;
    [self.view addSubview:_activityView];
    [self.view bringSubviewToFront:_activityView];
}
#pragma mark shareBtn
-(void)shareBtnClick{
    
}
-(void)collectBtnClick{
    
}
@end
