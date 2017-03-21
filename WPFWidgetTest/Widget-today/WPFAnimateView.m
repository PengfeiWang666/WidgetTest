//
//  WPFAnimateView.m
//  WidgetTest
//
//  Created by Leon on 2017/3/16.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFAnimateView.h"


@interface WPFAnimateView ()

@property (nonatomic, strong) UILabel      *name;
@property (nonatomic, strong) UIImageView  *iconView;
@property (nonatomic, strong) UIView       *lineView;
@property (nonatomic, strong) UIView       *rectView;

@end

@implementation WPFAnimateView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self buildSubview];
    }
    return self;
}

- (void)setupCell {
    
    //    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _rectView                   = [[UIView alloc] initWithFrame:CGRectMake(width - 60, 23, 35, 35)];
    _rectView.layer.borderWidth = 1.f;
    _rectView.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview:_rectView];
    
    _iconView       = [[UIImageView alloc] initWithFrame:CGRectMake(width - 62, 20, 40, 40)];
    _iconView.image = [UIImage imageNamed:@"plane"];
    _iconView.alpha = 0.f;
    [self addSubview:_iconView];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 300, 60)];
    _name.text = @"十一点在健德门开部门例会";
    _name.font = [UIFont systemFontOfSize:17.0f];
    _name.textColor = [UIColor blackColor];
    [self addSubview:_name];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(30, 70, 0, 2)];
    _lineView.alpha = 0.f;
    _lineView.backgroundColor = [UIColor redColor];
    [self addSubview:_lineView];
    
}

- (void)showIconAnimated:(BOOL)animated {
    
    if (animated) {
        
        _iconView.transform = CGAffineTransformMake(2, 0, 0, 2, 0, 0);
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             _iconView.alpha = 1.f;
                             _iconView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                             _lineView.alpha = 1.f;
                             _lineView.frame = CGRectMake(30, 70, 200, 2);
                             _name.frame = CGRectMake(30 + 50, 10, 300, 60);
                             
                             _rectView.layer.borderColor = [UIColor redColor].CGColor;
                             _rectView.transform = CGAffineTransformMake(0.8, 0, 0, 0.8, 0, 0);
                             _rectView.layer.cornerRadius = 4.f;
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    } else {
        _iconView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        _iconView.alpha     = 1.f;
        _lineView.alpha     = 1.f;
        _lineView.frame     = CGRectMake(30, 70, 200, 2);
        _name.frame         = CGRectMake(30 + 50, 10, 300, 60);
        
        _rectView.layer.borderColor  = [UIColor redColor].CGColor;
        _rectView.transform          = CGAffineTransformMake(0.8, 0, 0, 0.8, 0, 0);
        _rectView.layer.cornerRadius = 4.f;
    }
}

- (void)hideIconAnimated:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             _iconView.alpha     = 0.f;
                             _iconView.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0);
                             _lineView.alpha     = 0.f;
                             _lineView.frame     = CGRectMake(30, 70, 0, 2);
                             _name.frame         = CGRectMake(30, 10, 300, 60);
                             
                             _rectView.layer.borderColor  = [UIColor grayColor].CGColor;
                             _rectView.transform          = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                             _rectView.layer.cornerRadius = 0;
                         } completion:^(BOOL finished) {
                             
                         }];
    } else {
        _iconView.alpha     = 0.f;
        _lineView.alpha     = 0.f;
        _lineView.frame     = CGRectMake(30, 70, 0, 2);
        _name.frame         = CGRectMake(30, 10, 300, 60);
        
        _rectView.layer.borderColor  = [UIColor grayColor].CGColor;
        _rectView.transform          = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        _rectView.layer.cornerRadius = 0;
    }
}

- (void)showSelectedAnimation {
    
    UIView *tmpView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
    tmpView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.30];
    tmpView.alpha           = 0.f;
    
    [self addSubview:tmpView];
    
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tmpView.alpha = 0.8f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.20 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            tmpView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            
            [tmpView removeFromSuperview];
        }];
    }];
}





@end

