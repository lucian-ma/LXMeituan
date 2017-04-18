//
//  LXRushBuyCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/10.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXRushBuyCell.h"
@interface LXRushBuyCell(){
}
@end
@implementation LXRushBuyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (int i=0; i<3; i++) {
            UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(backViewOnTap:)];
            UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(LXScreen_width/3*i, 40, (LXScreen_width-3)/3, 80)];
            backView.tag=100+i;
            [backView addGestureRecognizer:pan];
            [self addSubview:backView];
            
            //
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (LXScreen_width-3)/3, 50)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            imageView.tag=i+20;
            [backView addSubview:imageView];
            //
            UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(i*LXScreen_width/3-1, 45, 0.5, 65)];
            lineView.backgroundColor=separaterColor;
            [self addSubview:lineView];
            
            //
//            UILabel * newPrice=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, backView.frame.size.width/2, 30)];
            
        }
        
    }
    return self;
}
-(void)backViewOnTap:(UIPanGestureRecognizer *)pan{
    
}
@end
