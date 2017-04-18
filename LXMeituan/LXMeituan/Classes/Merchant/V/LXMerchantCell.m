//
//  LXMerchantCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/12.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXMerchantCell.h"
#import "LXMerchantModel.h"
@interface LXMerchantCell(){
    UIImageView *_merchantImage;
    UILabel *_merchantNameLabel;//店名
    
    UILabel *_cateNameLabel;//店名
    
    UILabel *_evaluateLabel;//评价个数
}
@end
@implementation LXMerchantCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}
-(void)setUpViews{
    _merchantImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 72)];
    _merchantImage.layer.cornerRadius=4;
    _merchantImage.layer.masksToBounds=YES;
    [self.contentView addSubview:_merchantImage];
    
    
    _merchantNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 5, LXScreen_width-110-10, 30)];
    _merchantNameLabel.font=LXFont(15);
    _merchantNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_merchantNameLabel];
    
    //cateName
    _cateNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, LXScreen_width-110-10, 30)];
    _cateNameLabel.font = [UIFont systemFontOfSize:13];
    _cateNameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_cateNameLabel];
    
    //星星
    for (int i = 0; i < 5; i++) {
        UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(110+i*14, 43, 12, 12)];
        starImg.tag = 30+i;
        [starImg setImage:[UIImage imageNamed:@"icon_feedCell_star_empty"]];
        [self.contentView addSubview:starImg];
    }
    
    //评价个数
    _evaluateLabel = [[UILabel alloc] initWithFrame:CGRectMake(110+5*14, 40, 80, 20)];
    _evaluateLabel.font = [UIFont systemFontOfSize:13];
    _evaluateLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_evaluateLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 91.5, LXScreen_width, 0.5)];
    lineView.backgroundColor = LXGRB(192, 192, 192);
    [self.contentView addSubview:lineView];
}

-(void)setMerchantModel:(LXMerchantModel *)merchantModel{
    _merchantModel=merchantModel;
    NSString * imageUrlStr=[merchantModel.frontImg stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [_merchantImage sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    _merchantNameLabel.text=merchantModel.name;
    _cateNameLabel.text = [NSString stringWithFormat:@"%@  %@",merchantModel.cateName,merchantModel.areaName];
    
    _evaluateLabel.text = [NSString stringWithFormat:@"%@评价",merchantModel.markNumbers];
    
    double scoreD=[merchantModel.avgScore doubleValue];
    for (int i=0; i<5; i++) {
        UIImageView * imageView=[self.contentView viewWithTag:30+i];
        [imageView setImage:[UIImage imageNamed:@"icon_feedCell_star_empty"]];
    }
    for (int i =0; i<scoreD; i++) {
        UIImageView *imageview = (UIImageView *)[self.contentView viewWithTag:30+i];
        [imageview setImage:[UIImage imageNamed:@"icon_feedCell_star_full"]];
    }
}
@end
