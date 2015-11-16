//
//  MovieShopTableViewCell.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/28.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol movieShopTableViewCellDelegate <NSObject>

- (void)movieShopTableViewCellChangeViewWithAction;

@end

@interface MovieShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property(nonatomic, weak)id<movieShopTableViewCellDelegate> msDelegate;

@end
