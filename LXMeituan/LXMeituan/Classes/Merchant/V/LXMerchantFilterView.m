
//
//  LXMerchantFilterView.m
//  LXMeituan
//
//  Created by Noki on 2017/4/17.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXMerchantFilterView.h"
#import "LXNetworkSingleton.h"
#import "LXMerchantGroupModel.h"
#import "LXKindFilterCell.h"
@interface LXMerchantFilterView()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_bigGroupArray;//左边分组tableview的数据源
    NSMutableArray *_smallGroupArray;//右边分组tableview的数据源
    
    NSInteger _bigSelectedIndex;
    NSInteger _smallSelectedIndex;
}
@end
@implementation LXMerchantFilterView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _bigGroupArray = [[NSMutableArray alloc] init];
        _smallGroupArray = [[NSMutableArray alloc] init];
        
        [self initViews];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getCateListData];
        });
    }
    return self;
}

-(void)initViews{
    self.tableViewOfGroup=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width/2, self.height)style:UITableViewStylePlain];
    self.tableViewOfGroup.tag=10;
    self.tableViewOfGroup.delegate=self;
    self.tableViewOfGroup.dataSource=self;
    self.tableViewOfGroup.backgroundColor = [UIColor whiteColor];
    self.tableViewOfGroup.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableViewOfGroup];
    
    //详情
    self.tableViewOfDetail = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height) style:UITableViewStylePlain];
    self.tableViewOfDetail.tag = 20;
    self.tableViewOfDetail.dataSource = self;
    self.tableViewOfDetail.delegate = self;
    self.tableViewOfDetail.backgroundColor = LXGRB(242, 242, 242);
    self.tableViewOfDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableViewOfDetail];

}
-(void)getCateListData{
        NSString *urlStr = @"http://api.meituan.com/group/v1/poi/cates/showlist?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=hSjSxtGbfd1QtKRMWnoFV4GB8jU%3D&__skno=0DEF926E-FB94-43B8-819E-DD510241BCC3&__skts=1436504818.875030&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&cityId=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-10-12-44726&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    
    [LXNetworkSingleton GET:urlStr parameters:nil success:^(id responseObject) {
        NSMutableArray * dataArr=[responseObject objectForKey:@"data"];
        for (int i=0; i<dataArr.count; i++) {
            LXMerchantGroupModel * model=[LXMerchantGroupModel objectWithKeyValues:dataArr[i]];
            [_bigGroupArray addObject:model];
        }
        [self.tableViewOfGroup reloadData];
    } failure:^(NSError *error) {
        NSLog(@"获取cate分组信息失败:%@",error);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==10) {
        return _bigGroupArray.count;
    }else{
        if (_bigGroupArray.count==0) {
            return 0;
        }
        LXMerchantGroupModel *model=_bigGroupArray[_bigSelectedIndex];
        if (model.list==nil) {
            return 0;
        }else{
            return model.list.count;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==10) {
        static NSString *cellIndentifier = @"filterCell1";
        LXKindFilterCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell==nil) {
            cell=[[LXKindFilterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier withFrame:CGRectMake(0, 0, LXScreen_width/2, 42)];
        }
        cell.groupModel=_bigGroupArray[indexPath.row];
        cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = LXGRB(239, 239, 239);
        return cell;
    }else{
        static NSString *cellIndentifier = @"filterCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 41.5, cell.frame.size.width, 0.5)];
            lineView.backgroundColor = LXGRB(192, 192, 192);
            [cell.contentView addSubview:lineView];
        }
        LXMerchantGroupModel *model=_bigGroupArray[_bigSelectedIndex];
        cell.textLabel.text=[model.list[indexPath.row] objectForKey:@"name"];
        
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[model.list[indexPath.row] objectForKey:@"count"]];
        cell.textLabel.font=LXFont(15);
        cell.detailTextLabel.font=LXFont(13);
        cell.backgroundColor=LXGRB(242, 242, 242);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==10) {
        _bigSelectedIndex=indexPath.row;
        LXMerchantGroupModel * model=_bigGroupArray[_bigSelectedIndex];
        if (model.list==nil) {
            [self.tableViewOfDetail reloadData];
            [self.delegate tableVIew:tableView didSelectRowAtIndexPath:indexPath WithId:model.id WithName:model.name];
        }else{
            [self.tableViewOfDetail reloadData];
        }
    }else{
        _smallSelectedIndex=indexPath.row;
        LXMerchantGroupModel * model=_bigGroupArray[_bigSelectedIndex];

        NSDictionary * dic=model.list[_smallSelectedIndex];
        NSNumber *ID=dic[@"id"];
        NSString * name=dic[@"name"];
        [self.delegate tableVIew:tableView didSelectRowAtIndexPath:indexPath WithId:ID WithName:name];
    }
}
@end
