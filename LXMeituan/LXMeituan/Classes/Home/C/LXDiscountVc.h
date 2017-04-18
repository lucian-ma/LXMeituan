//
//  LXDiscountVc.h
//  LXMeituan
//
//  Created by Noki on 2017/4/11.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXDiscountVc : UIViewController
@property(nonatomic,strong)NSString * urlStr;

/**
 导航栏标题
 */
@property(nonatomic,copy)NSString * navTitle;
-(instancetype)initWithUrlString:(NSString *)url;
@end
