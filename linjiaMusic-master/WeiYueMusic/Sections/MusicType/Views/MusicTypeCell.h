//
//  MusicTypeCell.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/10.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicTypeModel.h"
@interface MusicTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTypeName;
@property (nonatomic, strong) MusicTypeModel *model;

@end
