//
//  SongTypeCollectionViewCell.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/15.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SongTypeModel;

@interface SongTypeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (nonatomic, strong) SongTypeModel *model;
@end
