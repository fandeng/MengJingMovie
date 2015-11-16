//
//  YYAnimationIndicator.m
//  AnimationIndicator
//
//  Created by 王园园 on 14-8-26.
//  Copyright (c) 2014年 王园园. All rights reserved.
//


#import "YYAnimationIndicator.h"

@implementation YYAnimationIndicator



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _isAnimating = NO;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width,frame.size.height-10)];
        [self addSubview:imageView];
        //设置动画帧
        imageView.animationImages=[NSArray arrayWithObjects: [UIImage imageNamed:@"two.png"],
                                   [UIImage imageNamed:@"three.png"],
                                   [UIImage imageNamed:@"four.png"],
                                   [UIImage imageNamed:@"five.png"],
                                   [UIImage imageNamed:@"six.png"],
                                   [UIImage imageNamed:@"one.png"],
                                   nil ];
        
        
        Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        Infolabel.backgroundColor = [UIColor clearColor];
        Infolabel.textAlignment = NSTextAlignmentCenter;
        Infolabel.textColor = [UIColor colorWithRed:84.0/255 green:86./255 blue:212./255 alpha:1];
        Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:14.0f];
        [self addSubview:Infolabel];
        self.layer.hidden = YES;
    }
    return self;
}


- (void)startAnimation
{
    
    [_indicator startAnimation];
    _isAnimating = YES;
    self.layer.hidden = NO;
    [self doAnimation];
}

-(void)doAnimation{
    
    Infolabel.text = _loadtext;
    //设置动画总时间
    imageView.animationDuration=1.0;
    //设置重复次数,0表示不重复
    imageView.animationRepeatCount=0;
    //开始动画
    [imageView startAnimating];
}

- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
{
    _isAnimating = NO;
    Infolabel.text = text;
    if(type){
        
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView stopAnimating];
            self.layer.hidden = YES;
            self.alpha = 1;
        }];
    }else{
        [imageView stopAnimating];
        [imageView setImage:[UIImage imageNamed:@"3"]];
    }
    
}


-(void)setLoadText:(NSString *)text;
{
    if(text){
        _loadtext = text;
    }
}

@end
