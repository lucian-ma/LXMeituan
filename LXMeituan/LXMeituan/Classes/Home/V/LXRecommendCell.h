//
//  LXRecommendCell.h
//  LXMeituan
//
//  Created by Noki on 2017/4/11.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@interface LXRecommendCell : UITableViewCell
@property(nonatomic, strong) UIImageView *shopImage;
@property(nonatomic, strong) UILabel *shopNameLabel;
@property(nonatomic, strong) UILabel *shopInfoLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *soldedLabel;


@property(nonatomic, strong) RecommendModel *recommendData;
@end
