//
//  UIView+HKExtension.h
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HKExtension)
@property(nonatomic,assign)CGFloat hk_width;
@property(nonatomic,assign)CGFloat hk_height;
@property(nonatomic,assign)CGFloat hk_x;
@property(nonatomic,assign)CGFloat hk_y;
@property(nonatomic,assign)CGFloat hk_centerX;
@property(nonatomic,assign)CGFloat hk_centerY;
@property(nonatomic,assign)CGFloat hk_right;
@property(nonatomic,assign)CGFloat hk_bottom;
@property(nonatomic,assign)CGSize hk_size;

+(instancetype)viewFromNib;

-(BOOL)intersectWithView:(UIView *)view;

-(void)startDuangAnimation;
-(void)startTransitionAnimation;
@end
