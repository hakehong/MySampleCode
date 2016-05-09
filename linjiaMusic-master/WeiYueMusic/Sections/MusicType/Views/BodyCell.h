//
//  BodyCell.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/10.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;

@interface BodyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *songImage;
@property (weak, nonatomic) IBOutlet UILabel *lblSongName;
@property (weak, nonatomic) IBOutlet UILabel *lblSingerName;
@property (weak, nonatomic) IBOutlet UILabel *lblFavoriteCount;

@property (nonatomic, strong) MusicModel *model;
@end
