//
//  LXMerchatDetailModel.h
//  LXMeituan
//
//  Created by Noki on 2017/4/17.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXMerchatDetailModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *avgScore;//星星
@property (nonatomic, strong) NSNumber *avgPrice;//人均
@property (nonatomic, strong) NSString *frontImg;//背景图
@property (nonatomic, strong) NSString *addr;//地址

@property (nonatomic, strong) NSString *phone;//电话
@property (nonatomic, strong) NSString *featureMenus;//推荐菜

@end
