//
//  goodsCollectionViewCell.h
//  
//
//  Created by 周子钦 on 15/10/27.
//
//

#import <UIKit/UIKit.h>

@interface goodsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
