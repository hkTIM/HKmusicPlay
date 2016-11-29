//
//  UIView+HKExtension.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "UIView+HKExtension.h"

@implementation UIView (HKExtension)
-(void)setHk_x:(CGFloat)hk_x
{
    CGRect frame = self.frame;
    frame.origin.x = hk_x;
    self.frame = frame;
}
-(CGFloat)hk_x
{
    return self.frame.origin.x;
}

-(void)setHk_size:(CGSize)hk_size
{
    CGRect frame = self.frame;
    frame.size = hk_size;
    self.frame = frame;
}

-(CGSize)hk_size
{
    return self.frame.size;
}

-(void)setHk_width:(CGFloat)hk_width
{
    CGRect frame = self.frame;
    frame.size.width = hk_width;
    self.frame = frame;
}
-(CGFloat)hk_width
{
    return self.frame.size.width;
}

-(void)setHk_height:(CGFloat)hk_height
{
    CGRect frame = self.frame;
    frame.size.height = hk_height;
    self.frame = frame;
}
-(CGFloat)hk_height
{
    return self.frame.size.height;
}


-(void)setHk_y:(CGFloat)hk_y
{
    CGRect frame = self.frame;
    frame.origin.y = hk_y;
    self.frame = frame;
}
-(CGFloat)hk_y
{
    return self.frame.origin.y;
}
-(void)setHk_centerX:(CGFloat)hk_centerX
{
    CGPoint center = self.center;
    center.x = hk_centerX;
    self.center = center;
}
-(CGFloat)hk_centerX
{
    return self.center.x;
}
-(void)setHk_centerY:(CGFloat)hk_centerY
{
    CGPoint center = self.center;
    center.y = hk_centerY;
    self.center = center;
}
-(CGFloat)hk_centerY
{
    return self.center.y;
}
-(void)setHk_right:(CGFloat)hk_right
{
    self.hk_x = hk_right - self.hk_width;
}
-(CGFloat)hk_right
{
    return CGRectGetMaxX(self.frame);
}

-(void)setHk_bottom:(CGFloat)hk_bottom
{
    self.hk_y = hk_bottom - self.hk_height;
}
-(CGFloat)hk_bottom
{
    return CGRectGetMaxY(self.frame);
}

+(instancetype)viewFromNib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect newRect = [self convertRect:self.bounds toView:window];
    CGRect newView = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(newRect, newView);
}

-(void)startDuangAnimation
{
    UIViewAnimationOptions op=UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent |UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
        [self.layer setValue:@(0.80) forKey:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
           [self.layer setValue:@(1.3) forKey:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
                [self.layer setValue:@(1) forKey:@"transform.scale"];
            } completion:NULL];
        }];
    }];
}
-(void)startTransitionAnimation
{
    CATransition *transition=[CATransition animation];
    transition.duration=1.0f;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type=kCATransitionFade;
    [self.layer addAnimation:transition forKey:nil];
}
@end
