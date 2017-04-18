//
//  ShopInfoModel.h
//  LXMeituan
//
//  Created by Noki on 2017/4/11.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfoModel : NSObject
@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSString *imgurl;
@property(nonatomic, strong) NSString *mname;
@property(nonatomic, strong) NSString *title;


@property(nonatomic, strong) NSNumber *price;
@property(nonatomic, strong) NSNumber *value;//原价

@property(nonatomic, strong) NSNumber *solds;//已售
@end
