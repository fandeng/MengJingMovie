//
//  ShowImageCell.h
//  UICollectionViewDemo
//
//  Created by Lee on 14-2-17.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageCell : UICollectionViewCell
{
    UIImageView * imageView;
    UILabel * is3DLabel;
    UILabel * maxLabel;
}


@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UILabel *is3DLabel;

@property(nonatomic, strong)UILabel * maxLabel;

@end
