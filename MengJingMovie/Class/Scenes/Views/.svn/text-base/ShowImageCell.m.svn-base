//
//  ShowImageCell.m
//  UICollectionViewDemo
//
//  Created by Lee on 14-2-17.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import "ShowImageCell.h"

@implementation ShowImageCell

@synthesize imageView;
@synthesize is3DLabel;
@synthesize maxLabel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        is3DLabel = [[UILabel alloc] init];
        is3DLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:is3DLabel];
        
        maxLabel = [[UILabel alloc] init];
        maxLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:maxLabel];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = self.contentView.bounds;
    is3DLabel.frame = CGRectMake(0.0f,0.0f , 50.0f, 44.0f);
    maxLabel.frame = CGRectMake(0.0f,49.0f , 50.f, 44.0f);
}
@end
