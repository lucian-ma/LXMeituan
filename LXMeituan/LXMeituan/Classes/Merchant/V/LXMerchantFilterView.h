//
//  LXMerchantFilterView.h
//  LXMeituan
//
//  Created by Noki on 2017/4/17.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXMerchantFilterDelegate<NSObject>
-(void)tableVIew:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath WithId:(NSNumber *)ID WithName:(NSString *)name;
@end
@interface LXMerchantFilterView : UIView
@property(nonatomic, strong) UITableView *tableViewOfGroup;
@property(nonatomic, strong) UITableView *tableViewOfDetail;
@property(nonatomic,assign)id<LXMerchantFilterDelegate>delegate;
@end
