//
//  LXKindFilterCell.h
//  LXMeituan
//
//  Created by Noki on 2017/4/17.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXMerchantGroupModel.h"
@interface LXKindFilterCell : UITableViewCell
@property(nonatomic,strong)LXMerchantGroupModel * groupModel;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame;
@end
