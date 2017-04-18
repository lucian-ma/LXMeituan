//
//  LXDiscountCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/10.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXDiscountCell.h"
#import "DiscountModel.h"
#import "UIImageView+WebCache.h"
@interface LXDiscountCell(){
    NSMutableArray * array;
}
@end;
@implementation LXDiscountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        for (int i=0; i<4; i++) {
            UIView * backView=[[UIView alloc]init];
            if (i<2) {
                backView.frame = CGRectMake(i*LXScreen_width/2, 0, LXScreen_width/2, 80);
            }else{
                backView.frame = CGRectMake((i-2)*LXScreen_width/2, 80, LXScreen_width/2, 80);
            }
            backView.tag=100+i;
            backView.layer.borderColor=separaterColor.CGColor;
            backView.layer.borderWidth=0.25;
            [self.contentView addSubview:backView];
            
            //点击事件
            UITapGestureRecognizer * pan=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapBackView:)];
            [backView addGestureRecognizer:pan];
            
            //标题
            UILabel * bigLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, LXScreen_width/2-10-60, 30)];
            bigLabel.font=[UIFont boldSystemFontOfSize:17];
            bigLabel.tag=200+i;
            [backView addSubview:bigLabel];
            //子标题
            UILabel  * subTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, LXScreen_width/2-10-60, 30)];
            subTitle.tag=220+i;
            subTitle.font=LXFont(12);
            [backView addSubview:subTitle];
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(LXScreen_width/2-10-60, 10, 60, 60)];
            imageView.tag = 240+i;
            [imageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 30;
            [backView addSubview:imageView];
            
        }
    }
    return self;
}
-(void)setDiscountArray:(NSMutableArray *)discountArray{
    _discountArray=discountArray;
    array=discountArray;
    
    for (int i =0; i<4; i++) {
        UILabel * bigLabel=[self viewWithTag:i+200];
        UILabel * subLabel=[self viewWithTag:i+220];
        UIImageView * imageView=[self viewWithTag:240+i];
        
        DiscountModel * model=discountArray[i];
        bigLabel.text=model.maintitle;
        bigLabel.textColor=[self colorWithHexString:model.typeface_color];
        subLabel.text=model.deputytitle;
        
        NSString * imageurl=[model.imageurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"120.0"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"%@",image);

        }

        ];
        
    }
        
}
    

- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

-(void)onTapBackView:(UIGestureRecognizer *)pan{
    NSInteger index=pan.view.tag-100;
    DiscountModel *model=_discountArray[index];
    
    NSString *str=@"as";
    NSNumber *num=[NSNumber numberWithLong:1];
    if ([model.type isEqualToValue:num]) {
        str=model.tplurl;
        NSRange range=[str rangeOfString:@"http"];
        str=[str substringFromIndex:range.location];
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectUrl:withType:withId:withTitle:)]) {
        [self.delegate didSelectUrl:str withType:model.type withId:model.id withTitle:model.maintitle];
    }
}
@end
