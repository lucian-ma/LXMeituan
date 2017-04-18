

//
//  LXDetailImageCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/18.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXDetailImageCell.h"
@interface LXDetailImageCell (){
    UIImageView *_bigImageView;
    UIImageView *_smallImageView;
    UILabel *_avgPriceLabel;
    UILabel *_shopNameLabel;
}
@end
@implementation LXDetailImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    _bigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, 160)];
    [_bigImageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    [self.contentView addSubview:_bigImageView];
    
    _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LXScreen_width-10-80, 85, 80, 80)];
    [_smallImageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    _smallImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _smallImageView.layer.borderWidth = 1;
    [self addSubview:_smallImageView];
    
    //店名
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, LXScreen_width-90-10, 30)];
    _shopNameLabel.textColor = [UIColor whiteColor];
    _shopNameLabel.text = @"优衣库店";
    _shopNameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_shopNameLabel];
    NSLog(@"优衣库种子：*********");
    //星星
    for (int i = 0; i < 5; ++i) {
        UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        starBtn.tag = 100 + i;
        starBtn.frame = CGRectMake(10+i*15, 130, 13, 13);
        [starBtn setImage:[UIImage imageNamed:@"icon_rating_star_not_picked"] forState:UIControlStateNormal];
        [starBtn setImage:[UIImage imageNamed:@"icon_rating_star_picked"] forState:UIControlStateSelected];
        [self addSubview:starBtn];
    }
    //人均
    _avgPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+5*15, 123, 80, 30)];
    _avgPriceLabel.textColor = [UIColor whiteColor];
    _avgPriceLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_avgPriceLabel];
}
-(void)setBigImgUrl:(NSString *)BigImgUrl{
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:BigImgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
}

-(void)setShopName:(NSString *)shopName{
    _shopNameLabel.text = shopName;
}

-(void)setAvgPrice:(NSNumber *)avgPrice{
    _avgPriceLabel.text = [NSString stringWithFormat:@"人均：%@元",avgPrice];
}

@end
