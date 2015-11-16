//
//  FindNewsDetailViewController.h
//  MengJingMovie
//
//  Created by mengjing on 15/10/24.
//  Copyright © 2015年 mengjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieShopModel.h"

@interface FindNewsDetailViewController : UIViewController

@property(nonatomic, strong)FindModel * model;

@property(nonatomic, strong)MovieShopModel * homeModel;

@property(nonatomic, assign)NSInteger opinionNumber;

@end
