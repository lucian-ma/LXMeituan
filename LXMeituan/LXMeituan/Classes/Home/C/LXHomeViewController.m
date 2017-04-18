//
//  LXHomeViewController.m
//  LXMeituan
//
//  Created by Noki on 2017/4/7.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXHomeViewController.h"
#import "LXHomeMenuCell.h"
#import "LXRushBuyCell.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "LXNetworkSingleton.h"
#import "DiscountModel.h"
#import "LXDiscountCell.h"
#import "LXDiscountVc.h"
#import "AppDelegate.h"
#import "RecommendModel.h"
#import "LXRecommendCell.h"
#import "LXShopViewVc.h"
@interface LXHomeViewController ()<UITableViewDelegate,UITableViewDataSource,LXDiscountCellDelegate>{
    NSArray * homeMenu;
    NSMutableArray * _RushBuyArr;
    NSMutableArray *_discountArray;
    NSMutableArray *_recommendArray;
}
@property(nonatomic,weak)UISearchBar * searchBar;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation LXHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:LXGRB(33, 192, 174)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpNavi];
    [self initData];
    [self initTableView];
    
}
-(void)initData{
    NSString * path=[[NSBundle mainBundle]pathForResource:@"menuData.plist" ofType:nil];
    homeMenu=[NSArray arrayWithContentsOfFile:path];
    
    _RushBuyArr =[NSMutableArray array];
    _discountArray=[NSMutableArray array];
    _recommendArray=[NSMutableArray array];
}
#pragma mark DiscountData
-(void)getDiscountData{
    NSString * url= @"http://api.meituan.com/group/v1/deal/topic/discount/city/1?ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-06-17-14-50363&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_trip_yidizhoubianyou__b__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___ab_pindaoquxincelue__a__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflow&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    
       __weak typeof(self) WeakSelf=self;
    [LXNetworkSingleton GET:url parameters:nil success:^(id responseObject) {
        if (WeakSelf) {
            NSMutableArray * dic=[responseObject objectForKey:@"data"];
            [_discountArray removeAllObjects];
            for (int i=0; i<dic.count; i++) {
                DiscountModel * model=[DiscountModel objectWithKeyValues:dic[i]];
                [_discountArray addObject:model];
            }
            [WeakSelf.tableView reloadData];
            [WeakSelf.tableView.gifHeader endRefreshing];
        }
    } failure:^(NSError *error) {
        NSLog(@"获取折扣数据失败：%@",error);
        [WeakSelf.tableView.header endRefreshing];
    }];
}
-(void)getRecommendData{
    __weak __typeof(self) weakself = self;

    NSString * url=[NSString stringWithFormat:@"http://api.meituan.com/group/v1/recommend/homepage/city/1?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=mrUZYo7999nH8WgTicdfzaGjaSQ=&__skno=51156DC4-B59A-4108-8812-AD05BF227A47&__skts=1434530933.303717&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&limit=40&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-06-17-14-50363&offset=0&position=%f,%f&userId=10086&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_trip_yidizhoubianyou__b__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___ab_pind",APPDELEGATE.latitude,APPDELEGATE.longitude];
    
   NSLog(@"最新的经纬度：%f,%f",APPDELEGATE.latitude,APPDELEGATE.longitude);
    [LXNetworkSingleton GET:url parameters:nil success:^(id responseObject) {
        NSMutableArray * dataDic=[responseObject objectForKey:@"data"];
        [_recommendArray removeAllObjects];
        for (int i=0; i<dataDic.count; i++) {
            RecommendModel *model=[RecommendModel objectWithKeyValues:dataDic[i]];
            [_recommendArray addObject:model];
        }
        [self.tableView reloadData];
        [weakself.tableView.gifHeader endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"推荐：%@",error);
        [weakself.tableView.header endRefreshing];
    }];
}
-(void)setUpNavi{
    UIBarButtonItem *negativeSeperatorl = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperatorl.width = -15;
    UIView *leftBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
    UILabel * cityLabel=[[UILabel alloc]init];
    cityLabel.text=@"北京";
    cityLabel.frame=CGRectMake(0, 0, 40, 25);
    cityLabel.font=LXFont(14);
    cityLabel.textColor=[UIColor whiteColor];
    [leftBarView addSubview:cityLabel];
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxY(cityLabel.frame)+5, 8, 13, 10)];
    imageView.image=[UIImage imageNamed:@"icon_homepage_downArrow"];
    [leftBarView addSubview:imageView];
    UIBarButtonItem  * leftBarItem=[[UIBarButtonItem alloc]initWithCustomView:leftBarView];
    self.navigationItem.leftBarButtonItems=@[negativeSeperatorl,leftBarItem];
    
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -20;
    UIButton * mapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [mapBtn setImage:[UIImage imageNamed:@"icon_homepage_map_old"] forState:UIControlStateNormal];
    mapBtn.frame=CGRectMake(0, 0, 42, 30);
    UIBarButtonItem * rightB=[[UIBarButtonItem alloc]initWithCustomView:mapBtn];
    rightB.width=-5;
    self.navigationItem.rightBarButtonItems=@[negativeSeperator,rightB];
    
    UIView * titleView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 30, 200, 25)];
    UISearchBar * search=[[UISearchBar alloc]init];
    search.frame=CGRectMake(10, 0, 200, 25);
    [titleView addSubview:search];
    search.layer.masksToBounds=YES;
    search.layer.cornerRadius=12;
    search.placeholder=@"Magic";
    self.searchBar=search;
    self.navigationItem.titleView=titleView;
}
-(void)initTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, LXScreen_height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    [self setUpTableView];
}
-(void)setUpTableView{
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    //设置普通状态的动画图片
    NSMutableArray * idelImage=[NSMutableArray array];
    for (NSInteger i=1; i<=60; i++) {
        UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        [idelImage addObject:image];
    }
    [self.tableView.gifHeader setImages:idelImage forState:MJRefreshHeaderStateIdle];
    
    //设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImages addObject:image];
    }
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    [self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    //马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
}
-(void)reloadData{
    NSLog(@"asd");

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getDiscountData];
        [self getRecommendData];
    });
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

#pragma mark delegate dataSoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==3) {
        return _recommendArray.count+1;
    }else{
    return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *homeMenuId=@"homeMenuCell";
        LXHomeMenuCell * cell=[tableView dequeueReusableCellWithIdentifier:homeMenuId];
        if (cell==nil) {
            cell=[[LXHomeMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeMenuId menuArr:homeMenu];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1){
        if (_RushBuyArr.count==0) {
            static NSString * cellid=@"noMoreData";
            UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
            
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                }
                return cell;
        } else{
                static NSString * cellId=@"rushBuy";
                LXRushBuyCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell==nil) {
                    cell=[[LXRushBuyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                   return cell;
            }
            
        }else if (indexPath.section==2){
        if (_discountArray.count==0) {
            static NSString * cellid=@"noMoreData";
            UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
            
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
              return cell;
            }else{
                static NSString * cellIden=@"discountCell";
                LXDiscountCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIden];
                if (cell==nil) {
                    cell=[[LXDiscountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
                    if (_discountArray!=0) {
                    }
                    cell.discountArray=_discountArray;
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.delegate=self;
            }
            return cell;
    }
        }else if (indexPath.section==3){
            if (indexPath.row==0) {
                static NSString * cellid=@"noMoreData";
                UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellid];
                
                if (cell==nil) {
                    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                }
                cell.textLabel.text=@"猜你喜欢";
                return cell;
            }else{
                static NSString * cellId=@"recommend";
                LXRecommendCell* cell=[tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell==nil) {
                    cell=[[LXRecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                }
                cell.recommendData=_recommendArray[indexPath.row-1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
    return 190;
    }else if (indexPath.section==1){
        if (_RushBuyArr.count==0) {
            return 0;
        }else{
            return 10;
        }
    }else if (indexPath.section==2){
        if (_discountArray.count==0) {
            return 0 ;
        }else{
            return 160;
        }
    }else if (indexPath.section==3){
        if (indexPath.row==0) {
            return 35;
        }else{
            return 100;
        }
    }
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        if (indexPath.row!=0) {
            LXShopViewVc * vc=[[LXShopViewVc alloc]init];
            RecommendModel * model=_recommendArray[indexPath.row-1];
            vc.shopID=[model.id stringValue];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
#pragma mark DiscountDelegate
-(void)didSelectUrl:(NSString *)urlStr withType:(NSNumber *)type withId:(NSNumber *)ID withTitle:(NSString *)title{
    NSNumber * num=[NSNumber numberWithLong:1];
    if ([type isEqualToValue:num]) {
        LXDiscountVc * vc=[[LXDiscountVc alloc]initWithUrlString:urlStr];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
