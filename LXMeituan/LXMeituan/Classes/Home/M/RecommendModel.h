//
//  RecommendModel.h
//  LXMeituan
//
//  Created by Noki on 2017/4/11.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject
@property(nonatomic, strong) NSNumber *dt;
@property(nonatomic, strong) NSString *cate;
@property(nonatomic, strong) NSString *range;
@property(nonatomic, strong) NSNumber *deposit;
@property(nonatomic, strong) NSString *mealcount;

@property(nonatomic, strong) NSString *mtitle;
@property(nonatomic, strong) NSMutableDictionary *tag;
@property(nonatomic, strong) NSNumber *state;
@property(nonatomic, strong) NSString *squareimgurl;
@property(nonatomic, strong) NSString *mlls;

@property(nonatomic, strong) NSNumber *solds;
@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *festcanuse;
@property(nonatomic, strong) NSNumber *dtype;

@property(nonatomic, strong) NSNumber *value;
//@property(nonatomic, strong) NSNumber *rate-count;
@property(nonatomic, strong) NSNumber *end;
@property(nonatomic, strong) NSString *imgurl;
@property(nonatomic, strong) NSString *mname;

@property(nonatomic, strong) NSMutableArray *pricecalendar;
@property(nonatomic, strong) NSMutableDictionary *optionalattrs;
@property(nonatomic, strong) NSString *brandname;
@property(nonatomic, strong) NSNumber *status;
@property(nonatomic, strong) NSString *bookinginfo;

@property(nonatomic, strong) NSString *smstitle;
@property(nonatomic, strong) NSNumber *ctype;
@property(nonatomic, strong) NSNumber *couponbegintime;
@property(nonatomic, strong) NSString *showtype;
@property(nonatomic, strong) NSString *subcate;

@property(nonatomic, strong) NSString *frontPoiCates;
@property(nonatomic, strong) NSNumber *couponendtime;
@property(nonatomic, strong) NSNumber *applelottery;
@property(nonatomic, strong) NSMutableArray *attrJson;
@property(nonatomic, strong) NSNumber *price;

@property(nonatomic, strong) NSNumber *start;
@property(nonatomic, strong) NSNumber *satisfaction;
@property(nonatomic, strong) NSString *digestion;
@property(nonatomic, strong) NSString *slug;
@property(nonatomic, strong) NSNumber *rating;

@property(nonatomic, strong) NSString *isAvailableToday;
@property(nonatomic, strong) NSNumber *nobooking;


@end
