//
//  NewCDCell.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/12.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewCDModel.h"

@interface NewCDCell : UICollectionViewCell
@property (nonatomic, strong) NewCDModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbumName;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbumSinger;

@end
