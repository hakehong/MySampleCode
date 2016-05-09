//
//  SingerCollectionCell.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/13.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SingerTypeModel;

@interface SingerCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *faceImage;
@property (weak, nonatomic) IBOutlet UILabel *lblNameTag;

@property (nonatomic, strong) SingerTypeModel *model;

@end
