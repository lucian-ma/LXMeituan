//
//  LXRecommendCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/11.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXRecommendCell.h"

@implementation LXRecommendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    _shopImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    _shopImage.layer.cornerRadius=4;
    _shopImage.layer.masksToBounds=YES;
    [self.contentView addSubview:_shopImage];
    
    UIImageView * yuyuView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    [yuyuView setImage:[UIImage imageNamed:@"ic_deal_noBooking"]];
    [self.contentView addSubview:yuyuView];
    
    //店名
    self.shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, LXScreen_width-100-80, 30)];
    [self.contentView addSubview:self.shopNameLabel];
    
    //介绍
    self.shopInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, LXScreen_width-100-10, 45)];
    self.shopInfoLabel.textColor = [UIColor lightGrayColor];
    self.shopInfoLabel.font = [UIFont systemFontOfSize:13];
    self.shopInfoLabel.numberOfLines = 2;
    self.shopInfoLabel.lineBreakMode = NSLineBreakByCharWrapping|NSLineBreakByTruncatingTail;
    [self.contentView addSubview:self.shopInfoLabel];

    //价格
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
}
-(void)setRecommendData:(RecommendModel *)recommendData{
    _recommendData=recommendData;
    
    NSString * imageUrl=[_recommendData.squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    self.shopNameLabel.text=recommendData.mname;
    self.shopInfoLabel.text = [NSString stringWithFormat:@"[%@]%@",recommendData.range,recommendData.title];
    NSString *priceStr = [NSString stringWithFormat:@"%d元",[recommendData.price intValue]];
    CGRect size=[priceStr boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:LXFont(17)} context:nil];
    self.priceLabel.text=priceStr;
    self.priceLabel.frame=CGRectMake(100, 75, size.size.width+10, 20);
}
@end
