//
//  LXMerchantVc.m
//  LXMeituan
//
//  Created by Noki on 2017/4/7.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXMerchantVc.h"
#import "AppDelegate.h"
#import <MJRefresh/MJRefresh.h>
#import "LXNetworkSingleton.h"
#import "LXMerchantModel.h"
#import "LXMerchantCell.h"
#import "LXMerchantFilterView.h"
#import "LXMerchantDetailVC.h"
@interface LXMerchantVc ()<UITableViewDelegate,UITableViewDataSource,LXMerchantFilterDelegate,UIGestureRecognizerDelegate>{

    UIView * _maskView;
    NSInteger _KindID;//分类查询ID，默认-1
        NSInteger _offset;
    NSMutableArray *_MerchantArray;
    NSString *_locationInfoStr;
    LXMerchantFilterView * _groupView;
}
@end

@implementation LXMerchantVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initData];
    [self setNavi];
    [self setViews];
    [self setUpTableView];
    [self initMaskView];

}
-(void)setNavi{
    UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"icon_map" ] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(0, 0, 23, 23);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton * rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(0, 0, 23, 23);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    NSArray * segmentArr=@[@"1",@"2"];
    UISegmentedControl * segment=[[UISegmentedControl alloc]initWithItems:segmentArr ];
    segment.frame   =     CGRectMake(0, 0, 160, 30);
    segment.layer.cornerRadius=5;
    segment.layer.masksToBounds=YES;
    segment.selectedSegmentIndex=0;
    segment.tintColor=LXGRB(33, 192, 174);
    [segment setTitle:@"全部商家" forSegmentAtIndex:0];
    [segment setTitle:@"优惠商家" forSegmentAtIndex:1];
    
    self.navigationItem.titleView=segment;
}
-(void)setViews{
    UIView * filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, 40)];
    filterView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:filterView];
    
    NSArray * filterArr=@[@"全部",@"全部",@"智能排序"];
    for (int i=0; i<3; i++) {
        //文字
        UIButton * filterBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        filterBtn.frame=CGRectMake(i*LXScreen_width/3, 0, LXScreen_width/3-15, 40);
        [filterBtn setTitle:filterArr[i] forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [filterBtn setTitleColor:LXGRB(33, 192, 174) forState:UIControlStateSelected];
        filterBtn.tag=100+i;
        filterBtn.titleLabel.font=LXFont(13);
        [filterView addSubview:filterBtn];
        [filterBtn addTarget:self action:@selector(OnFilterBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //三角
        UIButton * sanjiaoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sanjiaoBtn.frame=CGRectMake(CGRectGetMaxX(filterBtn.frame), 16, 8, 7);
        sanjiaoBtn.tag=200+i;
        [sanjiaoBtn setImage:[UIImage imageNamed:@"icon_arrow_dropdown_normal"] forState:UIControlStateNormal];
        [sanjiaoBtn setImage:[UIImage imageNamed:@"icon_arrow_dropdown_selected"] forState:UIControlStateSelected];
        [filterView addSubview:sanjiaoBtn];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, LXScreen_width, 0.5)];
    lineView.backgroundColor = LXGRB(192, 192, 192);
    [filterView addSubview:lineView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, LXScreen_width, LXScreen_height-40-64-49)style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}
-(void)setUpTableView{
    [_tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    NSMutableArray * idelImages=[NSMutableArray array];
    for (int i =1; i<=60; i++) {
        UIImage * image=[UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        [idelImages addObject:image];
    }
    [_tableView.gifHeader setImages:idelImages forState:MJRefreshHeaderStateIdle];
    
    NSMutableArray * pullImages=[NSMutableArray array];
    for (int i =1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [pullImages addObject:image];
    }
    [_tableView.gifHeader setImages:pullImages forState:MJRefreshHeaderStatePulling];
    [_tableView.gifHeader setImages:pullImages forState:MJRefreshHeaderStateRefreshing];
    [_tableView.gifHeader beginRefreshing];

    [_tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.gifFooter setRefreshingImages:pullImages];
    [_tableView.gifFooter setTitle:@"" forState:MJRefreshFooterStateIdle];
}
-(void)initData{
    _MerchantArray = [[NSMutableArray alloc] init];
    _offset = 0;
    _KindID = -1;//默认-1
}
//获取商家数据
-(void)getMerchantData{
    AppDelegate * appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str = @"%2C";
    
    NSString *hostStr = @"http://api.meituan.com/group/v1/poi/select/cate/";
    NSString *paramsStr = @"?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=WOdaAXJTFxIjDdjmt1z%2FJRzB6Y0%3D&__skno=91D0095F-156B-4392-902A-A20975EB9696&__skts=1436408836.151516&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&areaId=-1&ci=1&cityId=1&client=iphone&coupon=all&limit=20&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-09-09-42570&mypos=";
    NSString *str1 = [NSString stringWithFormat:@"%@%ld%@",hostStr,(long)_KindID,paramsStr];
    
    NSString *str2 = @"&sort=smart&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
        NSString *urlStr = [NSString stringWithFormat:@"%@%f%@%f&offset=%zd%@",str1, appDelegate.latitude, str, appDelegate.longitude, _offset,str2];
    __weak typeof(self)weakSelf=self;
    [LXNetworkSingleton GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"获取商家列表成功");
        NSMutableArray * arr=[responseObject objectForKey:@"data"];
        if (_offset==0) {
            [_MerchantArray removeAllObjects];
        }
        if(arr.count==0){
            [weakSelf.tableView.gifFooter noticeNoMoreData];
            return ;
        }
        for (int i=0; i<arr.count; i++) {
            LXMerchantModel * model=[LXMerchantModel objectWithKeyValues:arr[i]];
            [_MerchantArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        
        if (_offset==0 &&arr.count!=0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"获取商家列表失败：%@",error);
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
    }];
}
-(void)loadData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getMerchantData];
    });
}
-(void)loadMoreData{
    _offset=_offset+20;
    [self loadData];
}
-(void)initMaskView{
    _maskView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, LXScreen_width, LXScreen_height-40-49)];
    _maskView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:_maskView];
    _maskView.hidden=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewTap:)];
    tap.delegate=self;
    [_maskView addGestureRecognizer:tap];
    
    _groupView=[[LXMerchantFilterView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, _maskView.height-110)];
    _groupView.delegate=self;
    [_maskView addSubview:_groupView];
}
-(void)maskViewTap:(UITapGestureRecognizer  *)tap{
    _maskView.hidden=!_maskView.hidden;
    [self cancelAllSelected];
}
-(void)cancelAllSelected{
    for (int i=0; i<3; i++) {
        UIButton * sanjiaoBtn=[self.view viewWithTag:i+200];
        UIButton * filterBtn=[self.view viewWithTag:i+100];
        sanjiaoBtn.selected=NO;
        filterBtn.selected=NO;
    }
}
-(void)OnFilterBtn:(UIButton *)sender{
    [self cancelAllSelected];
    sender.selected=YES;
    UIButton * sanjiaoBtn=[self.view viewWithTag:sender.tag+100];
    sanjiaoBtn.selected=YES;
    _maskView.hidden=NO;
}
#pragma mark tableViewDelegate dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MerchantArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString * cellId=@"merchant";
    LXMerchantCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[LXMerchantCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.merchantModel=_MerchantArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, 30)];
    headView.backgroundColor=LXGRB(240, 239, 237);
    
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, LXScreen_width-50, 30)];
    label.font=LXFont(13);
    label.text=[NSString stringWithFormat:@"当前位置：%@",_locationInfoStr];
    label.textColor=[UIColor lightGrayColor];
    [headView addSubview:label];
    
    UIButton * refreshBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame=CGRectMake(LXScreen_width-30, 5, 20, 20);
    [refreshBtn setImage:[UIImage imageNamed:@"icon_dellist_locate_refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(OnRefreshLocationBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:refreshBtn];
    return headView;
}
-(void)OnRefreshLocationBtn:(UIButton *)sender{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getLocation];
    });
}
-(void)getLocation{
        NSString *urlStr = @"http://api.meituan.com/group/v1/city/latlng/39.982207,116.311906?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=dhdVkMoRTQge4RJQFlm2iIF2e5s%3D&__skno=9B646232-F7BF-4642-B9B0-9A6ED68003D2&__skts=1436408843.060582&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-09-09-42570&tag=1&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    _locationInfoStr = @"正在定位...";
    [self.tableView reloadData];
    __weak __typeof(self) weakself = self;

    [LXNetworkSingleton GET:urlStr parameters:nil success:^(id responseObject) {
        NSDictionary * dic=[responseObject objectForKey:@"data"];
        _locationInfoStr=dic[@"detail"];
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"获取当前位置信息失败:%@",error);
    }];
}

-(void)tableVIew:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath WithId:(NSNumber *)ID WithName:(NSString *)name{
    
    NSLog(@"%@----%@",name,ID);
    _KindID=[ID integerValue];
    _maskView.hidden=YES;
    [self cancelAllSelected];
    [self getFirstPage];
}

-(void)getFirstPage{
    _offset=0;
    [self  loadData];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    NSLog(@"%@",touch.view);

    if ([touch.view isKindOfClass:[UITableView class]]) {
        return NO;
    }
    if ([touch.view.superview isKindOfClass:[UITableView class]]) {
        //        NSLog(@"22222");
        return NO;
    }
    if ([touch.view.superview.superview isKindOfClass:[UITableView class]]) {
        //        NSLog(@"33333");
        return NO;
    }
    if ([touch.view.superview.superview.superview isKindOfClass:[UITableView class]]) {
        //        NSLog(@"44444");
        return NO;
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXMerchantModel * model=_MerchantArray[indexPath.row];
    LXMerchantDetailVC * detailVc=[[LXMerchantDetailVC alloc]init];
    detailVc.poiid=model.poiid;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
