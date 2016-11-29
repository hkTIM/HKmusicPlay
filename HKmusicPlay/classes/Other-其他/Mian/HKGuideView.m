//
//  HKGuideView.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/18.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKGuideView.h"

@interface HKGuideView()<UIScrollViewDelegate>
@property (strong ,nonatomic)UIScrollView *scrollView;

@property (strong ,nonatomic) UIPageControl *pageControl;
@end

@implementation HKGuideView

-(instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"%s",__func__);
    self=[super initWithFrame:frame];
    self.scrollView=[[UIScrollView alloc]initWithFrame:frame];
    [self addSubview:self.scrollView];
    self.scrollView.delegate=self;
    self.scrollView.bounces=NO; //下拉禁止显示空白处
    self.scrollView.pagingEnabled=YES; //是否整页翻动
    self.scrollView.showsVerticalScrollIndicator=NO;//是否显示滚动条---垂直方向
    self.scrollView.showsHorizontalScrollIndicator=NO;//是否显示滚动条---水平方向
    
    // 加载pagecontrol
    [self addSubview:self.pageControl];
    
    // 当需要记时混动时 调用 计时器
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(xx) userInfo:nil repeats:YES];
    
    //添加手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeobserver)];
    [self addGestureRecognizer:tap];
    
    return self;
}

-(void)removeobserver
{
    if (_pageControl.currentPage ==_guideImage.count-1) {
        [self removeFromSuperview];
    }
}


-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(self.hk_width*0.5, self.hk_height-60, 0, 40)];
//        _pageControl.backgroundColor=[UIColor blueColor];
        _pageControl.currentPageIndicatorTintColor=[UIColor lightGrayColor];//设置当前页的pageControl 颜色
        _pageControl.pageIndicatorTintColor=[UIColor blackColor];//设置pageControl 颜色
    }
    return  _pageControl;
}

-(void)setGuideImage:(NSArray *)guideImage
{
    _guideImage=guideImage;
    if (guideImage.count>0) {
        _pageControl.numberOfPages=guideImage.count;
        _scrollView.contentSize=CGSizeMake(guideImage.count*self.hk_width, self.hk_height);
        //遍历加载所有图片
        for (int i = 0; i<guideImage.count; i++) {
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.hk_width, 0, self.hk_width, self.hk_height)];
            [imageview setImage:[UIImage imageNamed:guideImage[i]]];
             [self.scrollView addSubview:imageview];
        }
    }
}
             
#pragma mark -- scrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset =scrollView.contentOffset;
    _pageControl.currentPage=round(offset.x/self.hk_width);
 
}
@end
