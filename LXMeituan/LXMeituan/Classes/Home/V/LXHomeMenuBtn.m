//
//  LXHomeMenuBtn.m
//  LXMeituan
//
//  Created by Noki on 2017/4/10.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXHomeMenuBtn.h"

@implementation LXHomeMenuBtn

-(instancetype)initWithFrame:(CGRect)frame image:(NSString * )image title:(NSString *)title{
    if (self=[super initWithFrame:frame]) {
        self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=LXFont(13);
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //self.imageView.frame= CGRectMake(frame.size.width/2-22, 15, 44, 44);
      //  self.titleLabel.frame=CGRectMake(0, 15+44, frame.size.width, 20);
   
         }
    return self;
}
#pragma mark - 调整内部ImageView的frame --
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = contentRect.size.width/2-22;
    CGFloat imageY = 15;
    CGFloat imageWidth = 44;
    CGFloat imageHeight = 44;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}
#pragma mark - 调整内部UIlable的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleHeight = 20;
    CGFloat titleY = 69;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}
@end
