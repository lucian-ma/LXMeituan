//
//  LXMerchantModel.h
//  LXMeituan
//
//  Created by Noki on 2017/4/12.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXMerchantModel : NSObject

@property (nonatomic, strong) NSString *frontImg;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *avgScore;//星星
@property (nonatomic, strong) NSNumber *markNumbers;//评价个数
@property (nonatomic, strong) NSString *cateName;

@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSNumber *avgPrice;
@property (nonatomic, strong) NSNumber *brandId;
@property (nonatomic, strong) NSString *poiid;
@end
