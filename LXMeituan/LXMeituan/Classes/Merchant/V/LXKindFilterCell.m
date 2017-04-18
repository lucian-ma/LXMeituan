//
//  LXKindFilterCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/17.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXKindFilterCell.h"
@interface LXKindFilterCell(){
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UIButton *_numberBtn;
}
@end
@implementation LXKindFilterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame=frame;
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
        _nameLabel.font=LXFont(15);
        [self.contentView addSubview:_nameLabel];
        
        _numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _numberBtn.frame = CGRectMake(self.frame.size.width-85, 12, 80, 15);
        _numberBtn.titleLabel.font=LXFont(11);
        _numberBtn.layer.cornerRadius = 7;
        _numberBtn.layer.masksToBounds = YES;
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateNormal];
        [_numberBtn setBackgroundImage:[UIImage imageNamed:@"film"] forState:UIControlStateHighlighted];
        [_numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_numberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_numberBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        lineView.backgroundColor = LXGRB(192, 192, 192);
        [self.contentView addSubview:lineView];
    }
    return self;
}


-(void)setGroupModel:(LXMerchantGroupModel *)groupModel{
    _groupModel=groupModel;
    _nameLabel.text=groupModel.name;
    
    if (groupModel.list == nil) {
        [_numberBtn setTitle:[NSString stringWithFormat:@"%@",groupModel.count] forState:UIControlStateNormal];
    }else{
        [_numberBtn setTitle:[NSString stringWithFormat:@"%@>",groupModel.count] forState:UIControlStateNormal];
    }
    NSString *str = [NSString stringWithFormat:@"%@>",groupModel.count];
    CGRect rect=[str boundingRectWithSize:CGSizeMake(80, 15) options:NSStringDrawingUsesLineFragmentOrigin |
                 NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:LXFont(14)} context:nil];
    _numberBtn.frame=CGRectMake(self.width-10-rect.size.width-10, 12, rect.size.width+10, 15);
}
@end
