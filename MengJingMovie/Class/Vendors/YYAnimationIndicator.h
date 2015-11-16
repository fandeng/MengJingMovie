//
//  YYAnimationIndicator.h
//  AnimationIndicator
//
//  Created by 王园园 on 14-8-26.
//  Copyright (c) 2014年 王园园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYAnimationIndicator : UIView

{
    UIImageView *imageView;
    UILabel *Infolabel;
}

@property (nonatomic, assign) NSString *loadtext;
@property (nonatomic, readonly) BOOL isAnimating;
@property(nonatomic, strong)YYAnimationIndicator *indicator;


//use this to init
- (id)initWithFrame:(CGRect)frame;
-(void)setLoadText:(NSString *)text;

- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;


@end
