//
//  LXDiscountCell.h
//  LXMeituan
//
//  Created by Noki on 2017/4/10.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LXDiscountCellDelegate <NSObject>
@optional
-(void)didSelectUrl:(NSString *)urlStr withType:(NSNumber *)type withId:(NSNumber *)ID withTitle:(NSString *)title;
@end
@interface LXDiscountCell : UITableViewCell
@property(nonatomic, strong) NSMutableArray *discountArray;
@property(nonatomic,assign)id<LXDiscountCellDelegate>delegate;
@end
