//
//  LXAroundGroupCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/18.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXAroundGroupCell.h"
@interface LXAroundGroupCell(){
    UIImageView *_shopImgView;
    UILabel *_shopNameLabel;
    UILabel *_shopSubTitleLabel;
    UILabel *_nowPriceLabel;
    UILabel *_oldPriceLabel;
}
@end
@implementation LXAroundGroupCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}
-(void)initViews{
    //图
    _shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    _shopImgView.layer.masksToBounds = YES;
    _shopImgView.layer.cornerRadius = 5;
    [self addSubview:_shopImgView];
    //店名
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, LXScreen_width-100-10, 20)];
    [self addSubview:_shopNameLabel];
    //子标题
    _shopSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, LXScreen_width-110, 50)];
    _shopSubTitleLabel.numberOfLines = 2;
    _shopSubTitleLabel.textColor = [UIColor lightGrayColor];
    _shopSubTitleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_shopSubTitleLabel];
    //新价格
    _nowPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 50, 20)];
    _nowPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_nowPriceLabel];
    //老价格
    _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nowPriceLabel.frame)+5, 70, 50, 20)];
    _oldPriceLabel.font = [UIFont systemFontOfSize:13];
    _oldPriceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_oldPriceLabel];
}
-(void)setDetailGroupModel:(LXMerchantAroundGroupModel *)detailGroupModel{
    _detailGroupModel=detailGroupModel;
    NSString  * imageStr=[detailGroupModel.squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.160"];
    [_shopImgView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    _shopNameLabel.text=detailGroupModel.mname;
    _shopSubTitleLabel.text=[NSString stringWithFormat:@"[%@]%@",detailGroupModel.range,detailGroupModel.title];
    
    NSString *str = [NSString stringWithFormat:@"%@元",detailGroupModel.price];
    _nowPriceLabel.text = str;
    CGRect rect=[str boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LXFont(17)} context:nil];
    _nowPriceLabel.frame=CGRectMake(100, 70, rect.size.width, rect.size.height);
    NSString *strOld = [NSString stringWithFormat:@"%@元",detailGroupModel.value];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //下划线
    //        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:strOld attributes:attribtDic];
    _oldPriceLabel.attributedText = attribtStr;
    _oldPriceLabel.frame = CGRectMake(CGRectGetMaxX(_nowPriceLabel.frame)+5, 70, 100, 20);
}
@end
