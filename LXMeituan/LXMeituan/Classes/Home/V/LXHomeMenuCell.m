
//
//  LXHomeMenuCell.m
//  LXMeituan
//
//  Created by Noki on 2017/4/10.
//  Copyright © 2017年 nuoki. All rights reserved.
//

#import "LXHomeMenuCell.h"
#import "LXHomeMenuBtn.h"
@interface LXHomeMenuCell ()<UIScrollViewDelegate>{
    UIView *_backView1;
    UIView *_backView2;
    UIPageControl *_pageControl;
}
@end
@implementation LXHomeMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArr:(NSArray *)meunArr{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, 160)];
        _backView2=[[UIView alloc]initWithFrame:CGRectMake(LXScreen_width, 0, LXScreen_width, 160)];
        
        UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, LXScreen_width, 180)];
        scrollView.contentSize=CGSizeMake(LXScreen_width *2, 180);
        scrollView.pagingEnabled=YES;
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.delegate=self;
        [scrollView addSubview:_backView1];
        [scrollView addSubview:_backView2];
        [self addSubview:scrollView];
        
        for (int i=0; i<16; i++) {
            if (i<4) {
                CGRect frame=CGRectMake(LXScreen_width/4*i, 0, LXScreen_width/4, 80);
                [self btnWithMenuArr:meunArr frame:frame index:i addToView:_backView1];
            }else if (i<8){
                CGRect frame=CGRectMake((i-4)*LXScreen_width/4, 80, LXScreen_width/4, 80);
                [self btnWithMenuArr:meunArr frame:frame index:i addToView:_backView1];
            }else if (i<12){
                CGRect frame=CGRectMake(LXScreen_width/4*(i-8), 0, LXScreen_width/4, 80);
                [self btnWithMenuArr:meunArr frame:frame index:i addToView:_backView2];
            }else{
                CGRect frame=CGRectMake(LXScreen_width/4*(i-12), 80, LXScreen_width/4, 80);
                [self btnWithMenuArr:meunArr frame:frame index:i addToView:_backView2];
            }
        }
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(LXScreen_width/2-20, 170, 0, 20)];
        _pageControl.currentPage=0;
        _pageControl.numberOfPages=2;
        [self addSubview:_pageControl];
        _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        _pageControl.pageIndicatorTintColor=[UIColor grayColor];
    }
    return self;
}
-(void)btnWithMenuArr:(NSArray *)meunArr frame:(CGRect)frame index:(NSInteger)index addToView:(UIView *)view{
    
    NSString *title=[meunArr[index] objectForKey:@"title"];
    NSString * image=[meunArr[index] objectForKey:@"image"];
    LXHomeMenuBtn * btn=[[LXHomeMenuBtn alloc]initWithFrame:frame image:image title:title];
    [btn addTarget:self action:@selector(homeMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}
-(void)homeMenuBtnClick:(UIButton *)sender{
    NSLog(@"homeMenuBtnClick");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW=scrollView.width;
    CGFloat x=scrollView.contentOffset.x;
    int page=(x+scrollViewW/2)/scrollViewW;
    _pageControl.currentPage=page;
}
@end
