//
//  LXDetailImageCell.h
//  LXMeituan
//
//  Created by Noki on 2017/4/18.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXDetailImageCell : UITableViewCell

@property(nonatomic, strong) NSString *BigImgUrl;
@property(nonatomic, strong) NSString *SmallImgUrl;
@property(nonatomic, strong) NSNumber *score;
@property(nonatomic, strong) NSNumber *avgPrice;
@property(nonatomic, strong) NSString *shopName;
@end
