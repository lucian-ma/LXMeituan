//
//  LXMerchantDetailVC.m
//  LXMeituan
//
//  Created by Noki on 2017/4/18.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXMerchantDetailVC.h"
#import "LXMerchatDetailModel.h"
#import "LXAroundGroupCell.h"
#import "LXNetworkSingleton.h"
#import "LXMerchantAroundGroupModel.h"
#import "LXDetailImageCell.h"
@interface LXMerchantDetailVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataSourceArray;
    NSMutableArray *_dealsArray;//附近团购数组
}

@end

@implementation LXMerchantDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataSourceArray=[NSMutableArray array];
    _dealsArray=[NSMutableArray array];
    [self setNavi];
    [self initViews];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getAroundData];
        [self getDetailData];
    });
}
-(void)setNavi{
        self.title=@"团购详情";
        
        UIButton * shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_normal"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_highlighted"] forState:UIControlStateHighlighted];
        shareBtn.frame=CGRectMake(0, 0, 22, 22);
    shareBtn.tag=100;
    [shareBtn addTarget:self action:@selector(shareOrCollectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithCustomView:shareBtn];
        
        UIButton * collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [collectBtn setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
        [collectBtn setImage:[UIImage imageNamed:@"icon_collect_highlighted"] forState:UIControlStateHighlighted];
        collectBtn.frame=CGRectMake(0, 0, 22, 22);
    collectBtn.tag=200;
    [collectBtn addTarget:shareBtn action:@selector(shareOrCollectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithCustomView:collectBtn];
        
        self.navigationItem.rightBarButtonItems=@[item1,item2];
}
-(void)initViews{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, LXScreen_height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
-(void)shareOrCollectBtnClick:(UIButton*)sender{
    if (sender.tag==100) {
        NSLog(@"share");
    }else{
        NSLog(@"collect");
    }
}

#pragma mark 请求数据
-(void)getDetailData{
    NSString *str1 = @"http://api.meituan.com/group/v1/poi/";
    NSString *str2 = @"?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=8s5pIPqAHXfwBBOWjWssJ6yhpP4%3D&__skno=3A22D2FC-4CE5-461F-8022-49617F529895&__skts=1437114388.938075&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-17-14-20300&userid=10086&utm_campaign=AgroupBgroupE72175652459578368_c0_eb21e98ced02c66e9539669c2efedfec0D100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__b__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    __weak __typeof(self) weakself = self;

    NSString * url=[NSString stringWithFormat:@"%@%@%@",str1,self.poiid,str2];
    [LXNetworkSingleton GET:url parameters:nil success:^(id responseObject) {
        NSMutableArray *dataArr=[responseObject objectForKey:@"data"];
        if (dataArr.count>0) {
            [_dataSourceArray removeAllObjects];
            LXMerchatDetailModel * model=[LXMerchatDetailModel objectWithKeyValues:dataArr[0]];
            [_dataSourceArray addObject:model];
            [weakself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商家详情请求失败:%@",error);
    }];
}
//获取附近团购
-(void)getAroundData{
    NSString *str1 = @"http://api.meituan.com/group/v1/recommend/nearstoredeals/poi/";
    NSString *str2 = @"?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=%2BKcL58MgLDsQfcX88AImaqHXAIw%3D&__skno=CF7C3655-49A4-43AF-AFB5-2AE1D7768521&__skts=1437114388.913142&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-17-14-20300&offset=0&userId=10086&userid=10086&utm_campaign=AgroupBgroupE72175652459578368_c0_eb21e98ced02c66e9539669c2efedfec0D100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__b__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",str1,self.poiid,str2];
    __weak __typeof(self) weakself = self;
    
    [LXNetworkSingleton GET:urlStr parameters:nil success:^(id responseObject) {
        NSDictionary * dic=[responseObject objectForKey:@"data"];
        NSMutableArray * dataArr=[dic objectForKey:@"deals"];
        for (int i=0; i<dataArr.count; i++) {
            LXMerchantAroundGroupModel * model=[LXMerchantAroundGroupModel objectWithKeyValues:dataArr[i]];
            [_dealsArray addObject:model];
        }
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"附近团购请求失败:%@",error);
    }];
}
#pragma mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_dealsArray.count>0) {
        return 3;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return _dealsArray.count+1;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString * cellId=@"cell0";
        LXDetailImageCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[LXDetailImageCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        }
        if (_dataSourceArray.count>0) {
            LXMerchatDetailModel * model=_dataSourceArray[0];
            cell.BigImgUrl = [model.frontImg stringByReplacingOccurrencesOfString:@"w.h" withString:@"300.200"];
            cell.shopName = model.name;
            cell.avgPrice = model.avgPrice;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1){
        static NSString * cellId=@"cell1";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            //位置坐标
            UIImageView *locationImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 18, 20, 20)];
            [locationImgView setImage:[UIImage imageNamed:@"icon_merchant_location"]];
            [cell addSubview:locationImgView];
            //位置信息
            UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 4, LXScreen_width-40-90, 50)];
            locationLabel.tag = 200;
            locationLabel.font = [UIFont systemFontOfSize:15];
            locationLabel.textColor = [UIColor grayColor];
            locationLabel.numberOfLines = 2;
            [cell addSubview:locationLabel];
            //
            UIImageView *telImgView = [[UIImageView alloc] initWithFrame:CGRectMake(LXScreen_width-35, 15, 19, 25)];
            [telImgView setImage:[UIImage imageNamed:@"icon_deal_phone"]];
            [cell addSubview:telImgView];
        }
        if (_dataSourceArray.count>0) {
            LXMerchatDetailModel * model=_dataSourceArray[0];
            UILabel *locationLabel = (UILabel *)[cell viewWithTag:200];
            locationLabel.text = model.addr;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            static NSString * cellId=@"20";
            UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            if (_dealsArray.count>0) {
                cell.textLabel.text=@"附近团购";
                cell.textLabel.textColor=[UIColor lightGrayColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else{
            static NSString * cellId=@"21";
            LXAroundGroupCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell==nil) {
                cell=[[LXAroundGroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            LXMerchantAroundGroupModel * groupModel=_dealsArray[indexPath.row-1];
            cell.detailGroupModel=groupModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        static NSString *cellIndentifier = @"detailCell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }else if(indexPath.section == 1){
        return 54;
    }else if (indexPath.section == 2){
        if (indexPath.row>0) {
            return 100;
        }
        return 40;
    }else{
        return 40;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.1;
    }
    return 5;
}
@end
